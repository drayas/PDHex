class DecksController < ApplicationController
  layout 'main'
  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
    @cards = Card.all
    @cards_in_deck = @deck.cards
  
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
end
