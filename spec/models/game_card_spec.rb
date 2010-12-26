require File.dirname(__FILE__) + '/../spec_helper'

describe GameCard do

  describe 'action list' do
    before(:each) do
      @game_card = GameCard.new
      @hand = GameContainer.new(:name => "hand")
    end
    it 'should have an action list' do
      @game_card.action_list(@hand).should_not be_nil
    end
    it 'should know how to format actions' do
      @game_card.format_actions([:graveyard]).should == [{
        :code           => :graveyard, 
        :display        => GameCard::ACTIONS[:graveyard][:display],
        :param_required => GameCard::ACTIONS[:graveyard][:param_required]
      }]
    end
  end #action list

  describe 'handle action' do
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
    describe 'an unknown code' do
      it 'should return an error when it does not understand the code' do 
        res, msg = @game_card.handle_action(:code => 'not_a_real_code', :container => @game_container)
        res.should be_false
        msg.should_not be_blank
      end
    end
    describe 'graveyard' do
      it 'should move the card to the graveyard' do
        @game_container.should_receive(:update_attribute).with(:game_card_ids, []).and_return(true)
        @graveyard.should_receive(:update_attribute).with(:game_card_ids, [1]).and_return(true)
        res, msg = @game_card.handle_action(:code => 'graveyard', :container => @game_container)
        res.should be_true
      end
    end
  end #handle action

end # Main describe
