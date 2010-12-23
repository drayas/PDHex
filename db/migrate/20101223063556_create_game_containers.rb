class CreateGameContainers < ActiveRecord::Migration
  def self.up
    create_table :game_containers do |t|
      t.string :name
      t.integer :game_deck_id
      t.text :game_card_ids
      t.timestamps
    end
  end

  def self.down
    drop_table :game_containers
  end
end
