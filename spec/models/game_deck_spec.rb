require File.dirname(__FILE__) + '/../spec_helper'

describe GameDeck do
  describe 'Preparing the game' do
    it 'should create game cards, containers, a library and a hand' do
      @game_deck = GameDeck.new
      @game_deck.should_receive(:create_containers)
      @game_deck.should_receive(:create_game_cards)
      @game_deck.should_receive(:setup_library)
      @game_deck.should_receive(:draw_hand)

      @game_deck.prepare!
    end
  end
end # main
