class CardsController < ApplicationController
  layout 'main'
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(params[:card])
    if @card.save
      redirect_to cards_path and return
    else
      flash[:error] = @card.errors.full_messages.join("<br>")
      render :action => :new
    end
  end

  def destroy
    @card = Card.find(params[:id])  
    @card.destroy
    redirect_to cards_path
  end
end
