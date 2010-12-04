class AddColorToCards < ActiveRecord::Migration
  def self.up
    add_column :cards, :color, :string
  end

  def self.down
    remove_column :cards, :color
  end
end
