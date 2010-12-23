class DecksController < ApplicationController
  layout 'main'
  def index
    @decks = Deck.all
  end

  # DECK BUILDER
  def show
    @deck = Deck.find(params[:id])
    @cards = Card.search(params[:search])
    @cards_in_deck = @deck.cards
    @search_params = params[:search] || {}
  end

  def new
    @deck = Deck.new
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update_attributes(params[:deck])
      redirect_to decks_path
    else
      flash[:error] = @deck.errors.full_messages.join("<br>")
      render :action => :edit, :id => @deck
    end
  end

  def create
    @deck = Deck.new(params[:deck])
    if @deck.save
      redirect_to decks_path and return
    else
      flash[:error] = @deck.errors.full_messages.join("<br>")
      render :action => :new
    end
  end

  def destroy
    @deck = Deck.find(params[:id])  
    @deck.destroy
    redirect_to decks_path
  end

  def add_card
    @deck = Deck.find_by_id(params[:id])
    @card = Card.find_by_id(params[:card_id])
    if @deck.nil? || @card.nil?
      flash[:error] = "Could not find the card with id #{params[:card_id].inspect}" if @card.nil?
      flash[:error] = "Could not find the deck with id #{params[:deck_id].inspect}" if @deck.nil?
    else
      @deck.add_card(@card)
    end

    if @deck
      redirect_to deck_path(@deck)
    else
      redirect_to decks_path
    end
  end

  def remove_card
    @deck = Deck.find_by_id(params[:id])
    @card = Card.find_by_id(params[:card_id])
    if @deck.nil? || @card.nil?
      flash[:error] = "Could not find the card with id #{params[:card_id].inspect}" if @card.nil?
      flash[:error] = "Could not find the deck with id #{params[:deck_id].inspect}" if @deck.nil?
    else
      @deck.remove_card(@card)
    end

    if @deck
      redirect_to deck_path(@deck)
    else
      redirect_to decks_path
    end
  end
end
