class CreateGameCards < ActiveRecord::Migration
  def self.up
    create_table :game_cards do |t|
      t.integer :game_deck_id
      t.integer :card_id
      t.timestamps
    end
  end

  def self.down
    drop_table :game_cards
  end
end
