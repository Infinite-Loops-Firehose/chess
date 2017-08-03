class PiecesController < ApplicationController

  def update
    @piece = Piece.find(params[:id])
    if @piece.save
      redirect_to @user
    else
      flash[:error] = @piece.errors
      redirect_to @user
    end
    # if @piece.invalid?(destination_x, destination_y) == true
    #   flash[:error] = @piece.errors "Invalid Move!"
    #   redirect_to @user
    # end
  end

  


end
