class GameUser < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  has_one :game_deck
end
