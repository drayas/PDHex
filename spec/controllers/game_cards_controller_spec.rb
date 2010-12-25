require File.dirname(__FILE__) + '/../spec_helper'

describe GameCardsController do
  describe 'Handling Actions' do
    before :each do
      @game_deck = GameDeck.new
      @game_card = GameCard.new(:game_deck => @game_deck)
      @game_container = GameContainer.new(:game_deck => @game_deck)
      GameCard.stub(:find).and_return(@game_card)
      GameContainer.stub(:find).and_return(@game_container)
      @game_card.stub(:id).and_return(1)
      @game_container.stub(:game_card_ids).and_return([1])
      @graveyard = GameContainer.new(:game_deck => @game_deck)
      @game_deck.stub(:graveyard).and_return(@graveyard)
    end
    it 'should invoke the game cards action handler' do
      @game_card.should_receive(:handle_action)
      post :handle_action, :id => 1, :game_container_id => 2, :code => 'graveyard'
    end
  end

end # main
