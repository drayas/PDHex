require File.dirname(__FILE__) + '/../spec_helper'

describe Deck do 
  describe 'Adding a card' do
    before(:each) do
      @deck = Deck.new
      @card = Card.new
    end
    it 'should be able to add a card' do
      @deck.cards.should_receive(:<<).with(@card)
      @deck.add_card(@card)
    end
  end

  describe 'Removing a card' do
    before(:each) do
      @deck = Deck.new
      @card = Card.new
    end
    it 'should be able to remove a card' do
      card_deck = CardDeck.new
      @deck.card_decks.should_receive(:find).and_return(card_deck)
      card_deck.should_receive(:destroy)
      @deck.should_receive(:reload)
      @deck.remove_card(@card)
    end
  end

  describe 'Finding cards in a deck' do
    before(:each) do
      @deck = Deck.new
      @card = Card.new
    end

    it 'should allow type' do
      @deck.cards.stub!(:find).and_return([@card])
      @deck.card_search(:type => 'land').should == [@card]
    end
    
  end
end # main describe
