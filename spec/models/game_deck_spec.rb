require File.dirname(__FILE__) + '/../spec_helper'

describe GameDeck do
  describe 'Preparing the game' do
    it 'should create game cards, containers, a library and a hand' do
      @game_deck = GameDeck.new
      @game_deck.should_receive(:create_containers)
      @game_deck.should_receive(:create_game_cards)
      @game_deck.should_receive(:setup_library)
      @game_deck.should_receive(:draw_cards).with(7)

      @game_deck.prepare!
    end
  end #Preparing the game
  describe 'Create the containers' do
    before :each do
      @game_deck = GameDeck.new
    end
    it 'should create the proper containers' do
      @game_deck.game_containers.should_receive(:create!).exactly(GameContainer::NAMES.size).times
      @game_deck.create_containers
    end
  end #Creating containers
  describe 'Create game cards' do
    before :each do
      @deck = Deck.new
      @game_deck = GameDeck.new(:deck => @deck)
      @deck.stub(:cards).and_return([Card.new, Card.new])
    end
    it 'should create the proper cards for each deck' do
      @game_deck.game_cards.should_receive(:create!).exactly(2).times
      @game_deck.create_game_cards
    end
  end #Creating game cards

  describe 'Setup library' do
    before :each do
      @game_deck = GameDeck.new
      @library = GameContainer.new(:game_deck => @game_deck, :name => 'library')
      @game_cards = []
      3.times do |i|
        card = GameCard.new
        card.stub(:id).and_return(i)
        @game_cards << card
      end
      @game_deck.stub(:game_cards).and_return(@game_cards)
      @game_deck.game_containers.stub(:find_by_name).and_return(@library)
    end
    it 'should load the game cards into the library and shuffle them' do

      @library.should_receive(:save!).and_return(true)
      @game_deck.setup_library
      @library.game_card_ids.sort.should == @game_cards.map(&:id).sort
    end
  end #Library setup

  describe 'Draw hand' do
    before :each do
      @game_deck = GameDeck.new
      @library = GameContainer.new(
        :game_deck     => @game_deck, 
        :name          => 'library',
        :game_card_ids => [1,2,3,4,5,6,7,8,9]
      )
      @hand = GameContainer.new(
        :game_deck     => @game_deck, 
        :name          => 'hand',
        :game_card_ids => []
      )
      @game_deck.stub(:library).and_return(@library)
      @game_deck.stub(:hand).and_return(@hand)
    end
    it 'should move the top 7 cards from the library into the hand' do
      @game_deck.draw_cards(7) 
      @library.game_card_ids.should == [1,2]
      @hand.game_card_ids.should == [9,8,7,6,5,4,3]
    end
  end #Draw hand
end # main
