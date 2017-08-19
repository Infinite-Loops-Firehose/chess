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
<<<<<<< HEAD
    current_game.forfeit(current_user)
    flash[:alert] = 'You forfeited the game :('
    redirect_to games_path
=======
    @game = Game.find(params[:id])
    if current_user.id == current_game.white_user_id
      @game.update_attributes(player_win: @game.user_white_id, player_lose: @game.user_black_id)
      black_user_id.update_attributes(games_won: black_user_id.games_won + 1)
    elsif current_user.id == current_game.black_user_id
      @game.update_attributes(player_win: @game.user_white_id, player_lose: @game.user_black_id)
      white_user_id.update_attributes(games_won: white_user_id.games_won + 1)
    end
    # flash[:alert] = "You forfeited the game :("
    redirect_to game_path(@game)
>>>>>>> c7e6bf63438685d3ef87c4f2d9c793a15b41f7c5
  end

  private

  def game_params
    params.require(:game).permit(:user_white_id, :user_black_id)
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
