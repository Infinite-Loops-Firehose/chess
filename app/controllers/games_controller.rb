class GamesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show update forfeit destroy]
  helper_method :game

  def index
    @available_games = Game.available
    @games_in_progress = Game.in_progress
    @games_ended = Game.ended
  end

  def new; end

  def create
    @game = Game.create(game_params)
    @game.populate_board!
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    gon.user_white_name = @game.user_white.name
    gon.user_black_name = @game.user_black.name unless @game.user_black.nil?
    gon.watch.is_white_turn = @game.is_white_turn
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
    GameChannel.broadcast_game_change('game_id' => @game.id, 'user_black_id' => @game.user_black_id)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to root_path
  end

  def forfeit
    @game = Game.find(params[:id])
    @game.update(state: Game::FORFEIT, player_lose: current_user.id, is_white_turn: nil)
    redirect_to game_path(@game)
    GameChannel.broadcast_game_change('game_id' => @game.id)
  end

  private

  def game_params
    params.require(:game).permit(:user_white_id, :user_black_id)
  end

end
