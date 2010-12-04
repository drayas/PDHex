class Card < ActiveRecord::Base
  validates_presence_of :name, :text, :card_type, :color

  def pretty_stats
    return "" if self.power.blank? && self.toughness.blank?
    "#{self.power}/#{self.toughness}"
  end

end
