class Deck < ActiveRecord::Base
  has_many :card_decks
  has_many :cards, :through => :card_decks

  def add_card(card)
    self.cards << card
  end

  def remove_card(card)
    cd = self.card_decks.find(:first, :conditions => ["card_id = ? and deck_id = ?", card.id, self.id])
    cd.destroy
    self.reload
  end

  def card_search(options = {})
    conditions = {}
    if options[:card_type]
      conditions[:card_type] = options[:card_type]
    end
    self.cards.find :all, :conditions => conditions
  end

end
