class GamesController < ApplicationController
  before_action :authenticate_user!, only: %i[:new, :create, :show]

  def new; end

  def create
    @game = Game.new(game_params)
    @game.user_white = current_user
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end
  
  def game_params
    params.require(:game).permit(:user_white_id, :user_black_id)
  end
end
