require File.dirname(__FILE__) + '/../spec_helper'

describe GamesController do
  before(:each) do
    @user = User.new(:name => "jim", :email => "jim@test.invalid", :password => "aoeu")
    User.stub!(:new).and_return(@user)
    @game = Game.create!
    @user.stub!(:games).and_return([@game])
  end

  describe 'index' do
    it 'should have a page with the games' do
      @user.should_receive(:games)
      get :index
      assigns(:games).should_not be_nil
    end
  end

  describe 'new' do
    it 'Should assign a new game' do
      get :new
      assigns(:game).should_not be_nil
    end
  end

  describe 'create' do
    it 'Should create a game and attach it to the user' do
      Game.should_receive(:create!).and_return(@game)
      @user.games.should_receive(:<<).with(@game)
      post :create
      response.should redirect_to game_path(@game)
    end
  end

  describe 'show' do
    before(:each) do
      Game.should_receive(:find).and_return(@game)
    end
    it 'Should show the game' do
      get :show, :id => @game
      assigns(:game).should == @game
    end
  end

end # main
