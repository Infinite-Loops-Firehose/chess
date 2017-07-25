class GamesController < ApplicationController
  def new; end

  def create 
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show 
    @game = Game.find(params[:game_id])
  end

  def game_params
    params.require(:game).permit(:user_white_id, :user_black_id)
  end
end
