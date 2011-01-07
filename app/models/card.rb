class Card < ActiveRecord::Base
  include ApplicationHelper
  has_many :card_decks
  has_many :decks, :through => :card_decks

  validates_presence_of :name, :card_type, :color
  validate :color_must_be_valid
  validate :card_type_must_be_valid

  COLORS = %w(red white blue green black colorless gold red_blue blue_green green_black black_white white_red black_red blue_black white_blue green_white red_green)
  CSV_COLOR_MAP = {
    "Art"       => "colorless",
    "Gld"       => "gold",
    "U"         => "blue",
    "B"         => "black",
    "Lnd"       => "colorless",
    "W"         => "white",
    "G"         => "green",
    "R"         => "red",
    "R/G"       => "red_green",
    "R/R"       => "red",
    "Gld/Gld"   => "gold",
    "R/U"       => "red_blue",
    "U/G"       => "blue_green",
    "G/B"       => "green_black",
    "B/W"       => "black_white",
    "W/R"       => "white_red",
    "B/R"       => "black_red",
    "U/B"       => "blue_black",
    "W/U"       => "white_blue",
    "G/W"       => "green_white"
  }
  CSV_TYPE_MAP = {
    "artifact"                          => 'artifact',
    "artifact creature"                 => 'artifact_creature',
    "artifact land"                     => 'land',
    "avatar"                            => 'creature',
    "basic land"                        => 'land',
    "basic snow land"                   => 'land',
    "character"                         => 'creature',
    "creature"                          => 'creature',
    "enchantment"                       => 'enchantment',
    "enchantment creature"              => 'enchantment',
    "instant"                           => 'instant',
    "instant/instant"                   => 'instant',
    "land"                              => 'land',
    "land creature"                     => 'creature',
    "legendary artifact"                => 'artifact',
    "legendary artifact creature"       => 'artifact_creature',
    "legendary creature"                => 'creature',
    "legendary enchantment"             => 'enchantment',
    "legendary land"                    => 'land',
    "legendary snow land"               => 'land',
    "planeswalker"                      => 'creature',
    "scariest creature you'll ever see" => 'creature',
    "snow artifact"                     => 'artifact',
    "snow artifact creature"            => 'artifact_creature',
    "snow creature"                     => 'creature',
    "snow enchantment"                  => 'enchantment',
    "snow land"                         => 'land',
    "sorcery"                           => 'sorcery',
    "sorcery/sorcery"                   => 'sorcery',
    "tribal artifact"                   => 'artifact',
    "tribal enchantment"                => 'enchantment',
    "tribal instant"                    => 'instant',
    "tribal sorcery"                    => 'sorcery',
    "world enchantment"                 => 'enchantment'
  }
  CARD_TYPES = %w(creature land instant sorcery enchantment artifact artifact_creature)
  SET_CODES = ["10E", "4E", "5E", "6E", "7E", "8E", "9E", "A", "AL", "ALA", "AN", "AP", "APL", "AQ", "ARB", "ARC", "ARE", "AT", "B", "BD", "BOK", "CFX", "CH", "CHK", "CHP", "CS", "CST", "DD2", "DDC", "DIS", "DK", "DLM", "DM", "DRB", "DS", "EUL", "EVE", "EVG", "EX", "FD", "FE", "FNM", "FUT", "GP", "GTW", "GUR", "HHL", "HL", "HPB", "IA", "IN", "JGC", "JU", "LE", "LG", "LRW", "M10", "MI", "MM", "MOR", "MR", "NE", "OD", "ON", "OV", "P2", "P3", "PLC", "PR", "PRE", "PS", "PT", "PY", "R", "RAV", "REL", "REW", "SC", "SH", "SHM", "SOK", "ST", "SUM", "TE", "THG", "TO", "TSB", "TSP", "U", "UD", "UG", "UL", "UNH", "US", "VG", "VI", "WL"]

  CSV_SET_MAP = {
    "10E"    => "10th Edition",
    "4E"     => "4th Edition",
    "5E"     => "5th Edition",
    "6E"     => "6th Edition",
    "7E"     => "7th Edition",
    "8E"     => "8th Edition",
    "9E"     => "9th Edition",
    "A"      => "Alpha",
    "AL"     => "Unknown Set",
    "ALA"    => "Unknown Set",
    "AN"     => "Unknown Set",
    "AP"     => "Unknown Set",
    "APL"    => "Unknown Set",
    "AQ"     => "Unknown Set",
    "ARB"    => "Unknown Set",
    "ARC"    => "Unknown Set",
    "ARE"    => "Unknown Set",
    "AT"     => "Unknown Set",
    "B"      => "Unknown Set",
    "BD"     => "Unknown Set",
    "BOK"    => "Unknown Set",
    "CFX"    => "Unknown Set",
    "CH"     => "Unknown Set",
    "CHK"    => "Unknown Set",
    "CHP"    => "Unknown Set",
    "CS"     => "Unknown Set",
    "CST"    => "Unknown Set",
    "DD2"    => "Unknown Set",
    "DDC"    => "Unknown Set",
    "DIS"    => "Unknown Set",
    "DK"     => "Unknown Set",
    "DLM"    => "Unknown Set",
    "DM"     => "Unknown Set",
    "DRB"    => "Unknown Set",
    "DS"     => "Unknown Set",
    "EUL"    => "Unknown Set",
    "EVE"    => "Unknown Set",
    "EVG"    => "Unknown Set",
    "EX"     => "Unknown Set",
    "FD"     => "Unknown Set",
    "FE"     => "Unknown Set",
    "FNM"    => "Unknown Set",
    "FUT"    => "Unknown Set",
    "GP"     => "Unknown Set",
    "GTW"    => "Unknown Set",
    "GUR"    => "Unknown Set",
    "HHL"    => "Unknown Set",
    "HL"     => "Unknown Set",
    "HPB"    => "Unknown Set",
    "IA"     => "Unknown Set",
    "IN"     => "Unknown Set",
    "JGC"    => "Unknown Set",
    "JU"     => "Unknown Set",
    "LE"     => "Unknown Set",
    "LG"     => "Unknown Set",
    "LRW"    => "Unknown Set",
    "M10"    => "Unknown Set",
    "MI"     => "Unknown Set",
    "MM"     => "Unknown Set",
    "MOR"    => "Unknown Set",
    "MR"     => "Unknown Set",
    "NE"     => "Unknown Set",
    "OD"     => "Unknown Set",
    "ON"     => "Unknown Set",
    "OV"     => "Unknown Set",
    "P2"     => "Unknown Set",
    "P3"     => "Unknown Set",
    "PLC"    => "Unknown Set",
    "PR"     => "Unknown Set",
    "PRE"    => "Unknown Set",
    "PS"     => "Unknown Set",
    "PT"     => "Unknown Set",
    "PY"     => "Unknown Set",
    "R"      => "Unknown Set",
    "RAV"    => "Unknown Set",
    "REL"    => "Unknown Set",
    "REW"    => "Unknown Set",
    "SC"     => "Unknown Set",
    "SH"     => "Unknown Set",
    "SHM"    => "Unknown Set",
    "SOK"    => "Unknown Set",
    "ST"     => "Unknown Set",
    "SUM"    => "Unknown Set",
    "TE"     => "Unknown Set",
    "THG"    => "Unknown Set",
    "TO"     => "Unknown Set",
    "TSB"    => "Unknown Set",
    "TSP"    => "Unknown Set",
    "U"      => "Unknown Set",
    "UD"     => "Unknown Set",
    "UG"     => "Unknown Set",
    "UL"     => "Unknown Set",
    "UNH"    => "Unknown Set",
    "US"     => "Unknown Set",
    "VG"     => "Unknown Set",
    "VI"     => "Unknown Set",
    "WL"     => "Unknown Set"
  }

  def pretty_stats
    pretty_stats_helper(self.power, self.toughness)
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
    limit  = "limit #{options[:limit] || 100} "
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

    # set
    unless options[:set].blank?
      where += " and [set] = ?"
      params << options[:set]
    end
    

    sql = ["#{select} #{from} #{where} order by name #{limit}"] + params
    Card.find_by_sql(sql)
  end

  def self.import_from_csv(filename = 'etc/cleaner_cards.csv')
    require 'fastercsv'
    csv = FasterCSV.open(filename)
    csv.each_with_index do |line,idx|
      # Some of the top elements don't have all the columns we need
      next unless line.size == 12
      card = Card.create(
        :name           => line[0],
        :set            => line[1],
        :color          => CSV_COLOR_MAP[line[2]],
        :card_type      => CSV_TYPE_MAP[line[3].split(' - ').first.downcase],
        :card_sub_type  => (line[3].include?(' - ') ? line[3].split(' - ').last : nil),
        :power          => (line[4].nil? ? nil : line[4].split('\\').first),
        :toughness      => (line[4].nil? ? nil : line[4].split('\\').last),
        :flavor         => line[5],
        :rarity         => line[6],
        :cost           => line[7],
        :text           => line[8],
        :unknown        => line[9],
        :artist         => line[10],
        :number_in_set  => line[11]
      )
      if card.new_record?
        puts "#{idx}: failure: #{card.inspect}"
      end
    end
    csv.close
  end
end
