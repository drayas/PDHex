require File.dirname(__FILE__) + '/../spec_helper'

describe DecksController do
  before(:each) do
  end

  describe 'index' do
    it 'should load a list of decks' do
      get :index
      assigns(:decks).should_not be_nil
    end
  end

  describe 'new' do
     it 'should create a new deck' do
      get :new
      assigns(:deck).should_not be_nil
     end
  end

  describe 'edit' do
     it 'should load an existing deck' do
      @deck = Deck.new
      Deck.should_receive(:find).and_return(@deck)
      get :edit
      assigns(:deck).should_not be_nil
     end
  end

  describe 'update' do
    it 'should update the deck and redirect to the listing' do
      @deck = Deck.new
      Deck.should_receive(:find).and_return(@deck)
      @deck.should_receive(:update_attributes).and_return(true)

      put :update, :id => @deck.id, :deck => @deck.attributes

      response.should redirect_to decks_path
    end
    it 'should set an error message and return to the edit page in the event of error' do
      @deck = Deck.new
      Deck.should_receive(:find).and_return(@deck)
      @deck.should_receive(:update_attributes).and_return(false)

      put :update, :id => @deck.id, :deck => @deck.attributes

      assigns(:deck).should == @deck
      flash[:error].should_not be_nil
      response.should_not redirect_to decks_path

    end
  end

  describe 'create' do
    before(:each) do
      @deck = Deck.new
    end
    it 'should make a deck given valid params' do
      Deck.should_receive(:new).and_return(@deck)
      @deck.should_receive(:save).and_return(true)

      post :create, :deck => @deck.attributes

      response.should redirect_to decks_path
    end
    it 'should return to new and set the flash with an invalid deck' do
      Deck.should_receive(:new).and_return(@deck)
      @deck.should_receive(:save).and_return(false)

      post :create, :deck => @deck.attributes

      assigns(:deck).should == @deck
      flash[:error].should_not be_nil
    end
  end

  describe 'delete' do
    before(:each) do
      @deck = Deck.new
    end
    it 'should delete the deck' do
      Deck.should_receive(:find).and_return(@deck)
      @deck.should_receive(:destroy)
      delete :destroy, :id => @deck.id 

      response.should redirect_to decks_path
    end
  end

  # Show is the deck builder
  describe 'show' do
    before(:each) do
      @deck = Deck.new
      Deck.stub!(:find).and_return(@deck)
      Card.stub!(:search).and_return([])
    end
    it "Should give a list of cards in the deck and a list of cards available" do
      get :show, :id => @deck.id
      assigns(:deck).should_not be_nil 
      assigns(:cards).should_not be_nil
      assigns(:cards_in_deck).should_not be_nil
      assigns(:search_params).should_not be_nil
    end
    it "Should use Card.search to filter our cards" do
      search_params = HashWithIndifferentAccess.new({:card_type => "land", :color => "blue"})
      Card.should_receive(:search).with(search_params).and_return('foo')
      get :show, :id => @deck.id, :search => search_params
      assigns(:cards).should == 'foo'
    end
  end

  describe 'adding a card to a deck' do
    before(:each) do
      @deck = mock_model Deck
      @card = mock_model Card
      Deck.stub!(:find_by_id).and_return(@deck)
      Card.stub!(:find_by_id).and_return(@card)
    end
    it 'should add the card to the deck' do
      @deck.should_receive(:add_card)
      post :add_card, :id => @deck, :card_id => @card
      response.should redirect_to deck_path(@deck)
    end
    it 'should handle a missing deck gracefully' do
      Deck.stub!(:find_by_id).and_return(nil)
      post :add_card, :id => @deck, :card_id => @card
      flash[:error].should_not be_nil 
      response.should redirect_to decks_path
    end
    it 'should handle a missing card gracefully' do
      Card.stub!(:find_by_id).and_return(nil)
      post :add_card, :id => @deck, :card_id => @card
      flash[:error].should_not be_nil 
      response.should redirect_to deck_path(@deck)
    end
  end

  describe 'removing a card from a deck' do
    before(:each) do
      @deck = mock_model Deck
      @card = mock_model Card
      Deck.stub!(:find_by_id).and_return(@deck)
      Card.stub!(:find_by_id).and_return(@card)
    end
    it 'should remove the card from the deck' do
      @deck.should_receive(:remove_card)
      post :remove_card, :id => @deck, :card_id => @card
      response.should redirect_to deck_path(@deck)
    end
    it 'should handle a missing deck gracefully' do
      Deck.stub!(:find_by_id).and_return(nil)
      post :remove_card, :id => @deck, :card_id => @card
      flash[:error].should_not be_nil 
      response.should redirect_to decks_path
    end
    it 'should handle a missing card gracefully' do
      Card.stub!(:find_by_id).and_return(nil)
      post :remove_card, :id => @deck, :card_id => @card
      flash[:error].should_not be_nil 
      response.should redirect_to deck_path(@deck)
    end
  end

end
