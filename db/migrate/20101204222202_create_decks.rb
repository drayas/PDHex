class CreateDecks < ActiveRecord::Migration
  def self.up
    create_table :decks do |t|
      t.string :name
      t.timestamps
    end
    create_table :card_decks do |t|
      t.integer :card_id
      t.integer :deck_id
    end
  end

  def self.down
    drop_table :decks
    drop_table :card_decks
  end
end
