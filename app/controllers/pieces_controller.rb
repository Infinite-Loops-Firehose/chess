class PiecesController < ApplicationController
  def show
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
  end
end
