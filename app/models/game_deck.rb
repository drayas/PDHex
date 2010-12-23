class GameDeck < ActiveRecord::Base
  belongs_to :game_user
  belongs_to :deck
  has_many :game_cards
  has_many :game_containers

  validates_presence_of :deck
  validates_presence_of :game_user

  def prepare!
    self.create_containers
    self.create_game_cards
    self.setup_library
    self.draw_hand
  end
end
