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
    @game = piece_to_move.game
    # params = {piece: {x_position: 5, y_position: 4}}
    # params[:piece] #{x_position: 5, y_position: 4}
    # params[:piece][:x_position] = #5
    piece_to_move.move_to!(params[:piece][:x_position], params[:piece][:y_position])
    @game.update_attributes(is_white_turn: !@game.is_white_turn)
    if @game.stalemate?(!piece_to_move.is_white)
      @game.update_attributes(state: Game::STALEMATE)
      @game.update_attributes(is_white_turn: nil)
    elsif @game.checkmate?(!piece_to_move.is_white)
      @game.update_attributes(state: Game::CHECKMATE)
      @game.update_attributes(is_white_turn: nil)
    end
  rescue ArgumentError => e
    render json: { error: e.message }, status: :bad_request
  end
end
