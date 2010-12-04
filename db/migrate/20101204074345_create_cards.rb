class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.string :name
      t.string :card_type
      t.string :card_sub_type
      t.string :cost
      t.string :power
      t.string :toughness
      t.text   :text
      t.text   :flavor
      t.timestamps
    end
  end

  def self.down
    drop_table :cards
  end
end
