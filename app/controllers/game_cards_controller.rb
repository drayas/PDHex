class GameCardsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def handle_action
    @game_card = GameCard.find(params[:id])
    @game_card.handle_action({
      :container => GameContainer.find(params[:game_container_id]),
      :code      => params[:code] 
    })
    render :text => 'KO'
  end
end
