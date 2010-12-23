class CreateGameDecks < ActiveRecord::Migration
  def self.up
    create_table :game_decks do |t|
      t.integer :game_user_id
      t.integer :deck_id
      t.timestamps
    end
  end

  def self.down
    drop_table :game_decks
  end
end
