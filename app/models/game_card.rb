class GameCard < ActiveRecord::Base
  belongs_to :game_deck
  belongs_to :card
end
