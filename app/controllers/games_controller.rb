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
    gon.watch.game_state = @game.state
    gon.watch.white_king_check = @game.check?(true)
    gon.watch.black_king_check = @game.check?(false)
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
    gon.watch.game_state = @game.state
    @game.update(state: Game::FORFEIT, player_lose: current_user.id)
    GameChannel.broadcast_player_forfeit('game_id' => @game.id, 'player_lose' => current_user.id)
  end

  private

  def game_params
    params.require(:game).permit(:user_white_id, :user_black_id)
  end

  def current_game
    @game ||= Game.find(params[:id])
  end
end
