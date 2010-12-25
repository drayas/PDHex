class GameContainer < ActiveRecord::Base
  belongs_to :game_deck
  serialize :game_card_ids, Array
  NAMES = %w(library hand graveyard in_play removed)

  def after_initialize
    self.game_card_ids ||= []
  end

  def cards
    self.game_card_ids.map{|gcid| GameCard.find(gcid).card}
  end
end
