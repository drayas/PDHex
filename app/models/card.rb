class Card < ActiveRecord::Base
  has_many :card_decks
  has_many :decks, :through => :card_decks

  validates_presence_of :name, :text, :card_type, :color
  validate :color_must_be_valid
  validate :card_type_must_be_valid

  COLORS = %w(red white blue green black colorless gold)
  CARD_TYPES = %w(creature land instant sorcery enchantment artifact)

  def pretty_stats
    return "" if self.power.blank? && self.toughness.blank?
    "#{self.power}/#{self.toughness}"
  end

  def color_must_be_valid
    if self.color.nil? || !COLORS.include?(self.color.downcase)
      self.errors.add_to_base("Invalid color")
      return false
    end
    return true
  end

  def card_type_must_be_valid
    if self.card_type.nil? || !CARD_TYPES.include?(self.card_type.downcase)
      self.errors.add_to_base("Invalid card type")
      return false
    end
    return true
  end

  def font_size
    return 10 if (self.text || "").split(' ').size <= 20
    return 9 if (self.text || "").split(' ').size <= 40
    return 7
  end
  def self.image_tag(str)
    str 
  end

  def self.search(options = {})
    options ||= {}
    select = "select c.*"
    from   = "from cards c"
    where  = "where 1=1"
    params = []

    # card_type
    unless options[:card_type].blank?
      where += " and card_type = ?"
      params << options[:card_type].downcase
    end

    # color
    unless options[:color].blank?
      where += " and color = ?"
      params << options[:color].downcase
    end

    sql = ["#{select} #{from} #{where}"] + params
    Card.find_by_sql(sql)
  end

end
