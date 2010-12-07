class GamesController < ApplicationController
  layout 'main'
  def index
    @games = @current_user.games
  end
  def new
    @game = Game.new
  end
  def create
    @game = Game.create!(params[:game])
    @current_user.games << @game
    redirect_to game_path(@game)
  end
  def show
    @game = Game.find params[:id]
  end
end
