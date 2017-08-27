class PiecesController < ApplicationController
  # def update
  #   @piece = Piece.find(params[:id])
  #   flash[:error] = @piece.errors if errors.present?
  #   redirect_to @user

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    # 1,1
    # 8, 8
    piece_to_move = Piece.find(params[:id])
    game_state = piece_to_move.game.state
    # params = {piece: {x_position: 5, y_position: 4}}
    # params[:piece] #{x_position: 5, y_position: 4}
    # params[:piece][:x_position] = #5
    piece_to_move.move_to!(params[:piece][:x_position], params[:piece][:y_position])
    # flash[:error] = 'That is an invalid move.' if piece_to_move.errors.present?
    # redirect_to game_path(piece_to_move.game)
    render json: piece_to_move
    if game_state != IN_PLAY
      render "games/show"
    end
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end
end
