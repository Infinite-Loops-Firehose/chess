class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    flash[:error] = @piece.errors if errors.present?
    redirect_to @user
  end
end
