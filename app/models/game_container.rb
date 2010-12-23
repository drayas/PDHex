class GameContainer < ActiveRecord::Base
  belongs_to :game_deck
  serialize :game_card_ids, Array
end
