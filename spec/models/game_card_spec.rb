require File.dirname(__FILE__) + '/../spec_helper'

describe GameCard do
  before(:each) do
    @user = User.new
    @card = Card.new(:name => 'Card name')
    @game_user = GameUser.new(:user => @user)
    @game_deck = GameDeck.new(:game_user => @game_user)
    @game_card = GameCard.new(:game_deck => @game_deck, :card => @card)
  end
  describe 'validations' do
    before(:each) do
      @valid_params = {}
    end
    it 'should be valid with a valid visibility' do
      GameCard::VISIBILITY_TYPES.each {|visibility|
        GameCard.new(@valid_params.merge({:visibility => visibility})).should be_valid
      }
    end
    it 'should be invalid with an invalid visibility' do
      GameCard.new(@valid_params.merge(:visibility => "not_a_visibility_type")).should_not be_valid
    end
  end
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
      @hand = GameContainer.new(:game_deck => @game_deck)
      @graveyard = GameContainer.new(:game_deck => @game_deck)
      @library = GameContainer.new(:game_deck => @game_deck)
      @in_play = GameContainer.new(:game_deck => @game_deck)
      @removed = GameContainer.new(:game_deck => @game_deck)
      @game_deck.stub(:hand).and_return(@hand)
      @game_deck.stub(:graveyard).and_return(@graveyard)
      @game_deck.stub(:library).and_return(@library)
      @game_deck.stub(:in_play).and_return(@in_play)
      @game_deck.stub(:removed).and_return(@removed)
    end
    describe 'an unknown code' do
      it 'should return an error when it does not understand the code' do 
        res, msg = @game_card.handle_action(:code => 'not_a_real_code', :container => @game_container)
        res.should be_false
        msg.should_not be_blank
      end
    end
    
    describe 'move cards' do
      it 'should move cards between the different game containers' do
        @game_container.should_receive(:update_attribute).with(:game_card_ids, []).and_return(true)
        @graveyard.should_receive(:update_attribute).with(:game_card_ids, [1]).and_return(true)
        @game_card.move(@game_container, @graveyard)
      end
    end

    describe 'hand' do
      it 'should move the card to the hand' do
        @game_container.should_receive(:update_attribute).with(:game_card_ids, []).and_return(true)
        @hand.should_receive(:update_attribute).with(:game_card_ids, [1]).and_return(true)
        res, msg = @game_card.handle_action(:code => 'hand', :container => @game_container)
        res.should be_true
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

    describe 'removed' do
      it 'should move the card to the removed' do
        @game_container.should_receive(:update_attribute).with(:game_card_ids, []).and_return(true)
        @removed.should_receive(:update_attribute).with(:game_card_ids, [1]).and_return(true)
        res, msg = @game_card.handle_action(:code => 'removed', :container => @game_container)
        res.should be_true
      end
    end
    
    describe 'deck_bottom' do
      it 'should move the card to the deck_bottom' do
        @game_container.should_receive(:update_attribute).with(:game_card_ids, []).and_return(true)
        @library.should_receive(:update_attribute).with(:game_card_ids, [1]).and_return(true)
        res, msg = @game_card.handle_action(:code => 'deck_bottom', :container => @game_container)
        res.should be_true
      end
    end

    describe 'deck_top' do
      it 'should move the card to the deck_top' do
        @game_container.should_receive(:update_attribute).with(:game_card_ids, []).and_return(true)
        @library.should_receive(:update_attribute).with(:game_card_ids, [1]).and_return(true)
        res, msg = @game_card.handle_action(:code => 'deck_top', :container => @game_container)
        res.should be_true
      end
    end

    describe 'play' do
      it 'should move the card to the in_play' do
        @game_container.should_receive(:update_attribute).with(:game_card_ids, []).and_return(true)
        @in_play.should_receive(:update_attribute).with(:game_card_ids, [1]).and_return(true)
        res, msg = @game_card.handle_action(:code => 'play', :container => @game_container)
        res.should be_true
      end
    end
    describe 'tap' do
      it 'should toggle the "tapped" attribute of the card' do
        @game_card.is_tapped = true
        @game_card.should_receive(:update_attribute).with(:is_tapped, false)
        res, msg = @game_card.handle_action(:code => 'tap', :contaioner => @game_container)
        @game_card.is_tapped = false
        @game_card.should_receive(:update_attribute).with(:is_tapped, true)
        res, msg = @game_card.handle_action(:code => 'tap', :contaioner => @game_container)
      end
    end
  end #handle action

  describe 'visibility' do 
    before(:each) do
      @another_user = User.new
    end

    it 'should only be visible to the owner if visibility type is player' do
      @game_card.visibility = "player"
      @game_card.visible?(@user).should be_true
      @game_card.visible?(@another_user).should be_false
    end

    it 'should be visible to everyone if the visibility type is all' do
      @game_card.visibility = "all"
      @game_card.visible?(@user).should be_true
      @game_card.visible?(@another_user).should be_true
    end
  end # Visibility

  describe 'display_text' do
    it 'should just display the name if nothing else pertains' do
      @game_card.display_text.should == @card.name.titlecase
    end
    it 'should alert the viewers if a card is tapped' do
      @game_card.is_tapped = true
      @game_card.display_text.should == "#{@card.name.titlecase} (T)"
    end
    it 'should show the casting cost if the card is in the hand container' do
      @card.cost = 'QQ'
      @container = GameContainer.new(:name => 'hand')
      @game_card.display_text(@container).should == "#{@card.name.titlecase} QQ"
    end
    it 'should show P/T while in_play' do
      @game_card.power = '1'
      @game_card.toughness = '2'
      @container = GameContainer.new(:name => 'in_play')
      @game_card.display_text(@container).should == "#{@card.name.titlecase} 1/2"
    end
    it 'should display counters if they exist'
  end
end # Main describe
