class GamesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show update]
  helper_method :game

  def index
    @available_games = Game.available
  end

  def new; end

  def create
    @game = Game.create(game_params)
    @game.populate_board!
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.user_black.nil?
      @game.update(user_black_id: current_user.id)
    else
      @game.update(user_white_id: current_user.id)
    end
    redirect_to game_path(@game)
  end


  def forfeit
    @game = Game.find(params[:id])
    if @game.current_user.id == user_white_id
      @game.update_attributes(player_win: @game.user_black_id, player_lose: @game.user_white_id)
    else
      @game.update_attributes(player_win: @game.user_white_id, player_lose: @game.user_black_id)
    end
    flash[:alert] = "You forfeited the game :("
    redirect_to game_path(@game)
  end

  private

  def game_params
    params.require(:game).permit(:user_white_id, :user_black_id)
  end
end
