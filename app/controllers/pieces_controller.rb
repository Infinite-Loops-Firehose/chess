class PiecesController < ApplicationController
  def show
    @piece = Piece.find(params[:id])
  end

  def update
    piece_to_move = Piece.find(params[:id])
    piece_to_move.move_to!(params[:x_position], params[:y_position])
    redirect_to game_path(piece_to_move.game)
  end
end
