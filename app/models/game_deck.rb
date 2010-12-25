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
    self.draw_cards(7)
  end

  def create_containers
    GameContainer::NAMES.each do |name|
      self.game_containers.create!(:name => name)
    end
  end

  def create_game_cards
    self.deck.cards.each do |card|
      self.game_cards.create!(:card_id => card.id)
    end
  end

  def setup_library
    library = self.game_containers.find_by_name('library')
    library.game_card_ids = self.game_cards.map(&:id).shuffle
    library.save!
  end

  def draw_cards(num)
    lib_ids = self.library.game_card_ids
    hand_ids = self.hand.game_card_ids
    num.times do
      hand_ids.push(lib_ids.pop)
    end
    self.library.update_attribute(:game_card_ids, lib_ids)
    self.hand.update_attribute(:game_card_ids, hand_ids)
  end

  def hand
    self.game_containers.find_by_name('hand')
  end

  def graveyard
    self.game_containers.find_by_name('graveyard')
  end

  def removed
    self.game_containers.find_by_name('removed')
  end

  def library
    self.game_containers.find_by_name('library')
  end
  
  def in_play
    self.game_containers.find_by_name('in_play')
  end
end
