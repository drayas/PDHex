class AddingFieldsToGameCards < ActiveRecord::Migration
  def self.up
    add_column :game_cards, :is_tapped, :boolean
    add_column :game_cards, :color, :string
    add_column :game_cards, :power, :string
    add_column :game_cards, :toughness, :string
    add_column :game_cards, :text, :text
    add_column :game_cards, :counters, :string
    add_column :game_cards, :card_sub_type, :string
    add_column :game_cards, :card_type, :string
  end

  def self.down
    remove_column :game_cards, :is_tapped
    remove_column :game_cards, :color
    remove_column :game_cards, :power
    remove_column :game_cards, :toughness
    remove_column :game_cards, :text
    remove_column :game_cards, :counters
    remove_column :game_cards, :card_sub_type
    remove_column :game_cards, :card_type
  end
end
