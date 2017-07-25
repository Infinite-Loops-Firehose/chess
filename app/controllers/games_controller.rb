class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def new; end

  def create 
    @game = game.create(game_params)
    redirect_to game_path(@game)
  end

  def show 
    @game = Game.find_by game_id:(params[:game_id])
  end

  def game_params
    params.require(:game).permit(:game_id, :user_white_id, :user_black_id)
  end
end
