class GameCardsController < ApplicationController
  def handle_action
    @game_card = GameCard.find(params[:id])
    @game_card.handle_action({
      :container => GameContainer.find(params[:game_container_id]),
      :code      => params[:code] 
    })
  end
end
