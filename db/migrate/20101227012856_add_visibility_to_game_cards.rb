class AddVisibilityToGameCards < ActiveRecord::Migration
  def self.up
    add_column :game_cards, :visibility, :string, :default => "player"
  end

  def self.down
    remove_column :game_cards, :visibility
  end
end
