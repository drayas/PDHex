class CreateGameUsers < ActiveRecord::Migration
  def self.up
    create_table :game_users do |t|
      t.integer :game_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :game_users
  end
end
