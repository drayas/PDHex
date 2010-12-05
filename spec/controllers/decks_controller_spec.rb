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

  describe 'show' do
    before(:each) do
      @deck = Deck.new
      Deck.stub!(:find).and_return(@deck)
    end
    it "Should give a list of cards in the deck and a list of cards available" do
      get :show, :id => @deck.id
      assigns(:deck).should_not be_nil 
      assigns(:cards).should_not be_nil
      assigns(:cards_in_deck).should_not be_nil
    end
  end

end
