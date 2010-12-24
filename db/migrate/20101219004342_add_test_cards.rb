class AddTestCards < ActiveRecord::Migration
  def self.up
    symbols = {
      "blue"     => "U",
      "red"      => "R",
      "black"    => "B",
      "white"    => "W",
      "green"    => "G",
      "artifact" => "1",
      "gold"     => "URBWG",
    }
    ["blue", "red", "black", "white", "green", "blue", "colorless", "gold"].each do |color|
      Card.create!(
        :name          => "Basic #{color} creature",
        :card_type     => "creature",
        :card_sub_type => "test critter",
        :cost          => symbols[color],
        :power         => "1",
        :toughness     => "1",
        :text          => "This is a sample #{color} creature.  <br><br>-#{symbols[color]}T-: Do something spiffy.",
        :flavor        => "Some flavor text for our #{color} creature.",
        :color         => color
      )
    end
  end

  def self.down
    Card.find_all_by_card_sub_type("test critter").map(&:destroy)
  end
end
