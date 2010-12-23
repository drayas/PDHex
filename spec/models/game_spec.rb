require File.dirname(__FILE__) + '/../spec_helper'

describe Game do
  describe "Starting a game" do
    before(:each) do
      @game = Game.new
      @game_user = GameUser.new
      @game_deck = GameDeck.new
      @user1 = User.new(:name => "Jim")
      @user2 = User.new(:name => "Bob")
      @deck = Deck.new
      @valid_params = [
        {:user => @user1, :deck => @deck},
        {:user => @user2, :deck => @deck}
      ]

      Game.stub!(:create!).and_return(@game)
      GameUser.stub!(:create!).and_return(@game_user)
      GameDeck.stub!(:create!).and_return(@game_deck)

      @game_deck.stub!(:prepare!)
    end

    it 'should require more than 1 player' do
      lambda {Game.start!([{:user => 1, :deck => 2}])}.should raise_error
    end

    it 'should require every player to have a deck' do
      lambda do
        Game.start!([
          {:user => 1},
          {:user => 2, :deck => 3},
        ])
      end.should raise_error
    end

    it 'should do something if the starting data structure is wrong' do
      lambda {Game.start!("not right")}.should raise_error
    end
    
    it 'should create a game' do
      Game.should_receive(:create!)
      Game.start!(@valid_params)  
    end

    it 'should create game users and add them to the game' do
      GameUser.should_receive(:create!).exactly(2).times
      Game.start!(@valid_params)  
    end

    it 'should create game decks for each user' do
      GameDeck.should_receive(:create!).exactly(2).times
      Game.start!(@valid_params)  
    end

    it 'should initialize the game decks' do
      @game_deck.should_receive(:prepare!).exactly(2).times
      Game.start!(@valid_params)  
    end

    it 'should give the game a name based on the players' do
      @game.should_receive(:update_attribute).with(:name, "Game between Jim and Bob")
      Game.start!(@valid_params)  
    end
  end # starting a game
end # main
