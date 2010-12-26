class AddNewCardColumnsForCsv < ActiveRecord::Migration
  def self.up
    add_column :cards, :set, :string
    add_column :cards, :rarity, :string
    add_column :cards, :unknown, :string
    add_column :cards, :artist, :string
    add_column :cards, :number_in_set, :string
  end

  def self.down
    remove_column :cards, :set
    remove_column :cards, :rarity
    remove_column :cards, :unknown
    remove_column :cards, :artist
    remove_column :cards, :number_in_set
  end
end
