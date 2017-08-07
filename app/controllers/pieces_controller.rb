class PiecesController < ApplicationController
  # def update
  #   @piece = Piece.find(params[:id])
  #   flash[:error] = @piece.errors if errors.present?
  #   redirect_to @user

  def show
    @piece = Piece.find(params[:id])
  end

  def update
    piece_to_move = Piece.find(params[:id])
    piece_to_move.move_to!(params[:x_position], params[:y_position])
    flash[:error] = @piece.errors if errors.present?
    redirect_to game_path(piece_to_move.game)
  end
end
