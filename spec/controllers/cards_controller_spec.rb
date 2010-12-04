require File.dirname(__FILE__) + '/../spec_helper'

describe CardsController do
  before(:each) do
  end

  describe 'index' do
    it 'should load a list of cards' do
      get :index
      assigns(:cards).should_not be_nil
    end
  end

  describe 'new' do
     it 'should create a new card' do
      get :new
      assigns(:card).should_not be_nil
     end
  end

  describe 'create' do
    before(:each) do
      @card = Card.new
    end
    it 'should make a card given valid params' do
      Card.should_receive(:new).and_return(@card)
      @card.should_receive(:save).and_return(true)

      post :create, :card => @card.attributes

      response.should redirect_to cards_path
    end
    it 'should return to new and set the flash with an invalid card' do
      Card.should_receive(:new).and_return(@card)
      @card.should_receive(:save).and_return(false)

      post :create, :card => @card.attributes

      assigns(:card).should == @card
      flash[:error].should_not be_nil
    end
  end

  describe 'delete' do
    before(:each) do
      @card = Card.new
    end
    it 'should delete the card' do
      Card.should_receive(:find).and_return(@card)
      @card.should_receive(:destroy)
      delete :destroy, :id => @card.id 

      response.should redirect_to cards_path
    end
  end

end
