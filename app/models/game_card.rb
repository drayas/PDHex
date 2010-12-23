class GameCard < ActiveRecord::Base
  belongs_to :game_deck
end
