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

  describe 'edit' do
     it 'should load an existing card' do
      @card = Card.new
      Card.should_receive(:find).and_return(@card)
      get :edit
      assigns(:card).should_not be_nil
     end
  end

  describe 'update' do
    it 'should update the card and redirect to the listing' do
      @card = Card.new
      Card.should_receive(:find).and_return(@card)
      @card.should_receive(:update_attributes).and_return(true)

      put :update, :id => @card.id, :card => @card.attributes

      response.should redirect_to cards_path
    end
    it 'should set an error message and return to the edit page in the event of error' do
      @card = Card.new
      Card.should_receive(:find).and_return(@card)
      @card.should_receive(:update_attributes).and_return(false)

      put :update, :id => @card.id, :card => @card.attributes

      assigns(:card).should == @card
      flash[:error].should_not be_nil
      response.should_not redirect_to cards_path

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
