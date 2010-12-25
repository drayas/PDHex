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
  end

end # Main describe
