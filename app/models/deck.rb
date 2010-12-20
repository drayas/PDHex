class Deck < ActiveRecord::Base
  has_many :card_decks
  has_many :cards, :through => :card_decks

  def add_card(card)
    self.cards << card
  end

  def remove_card(card)
    self.cards.delete(card)
  end

  def card_search(options = {})
    conditions = {}
    if options[:card_type]
      conditions[:card_type] = options[:card_type]
    end
    self.cards.find :all, :conditions => conditions
  end

end
