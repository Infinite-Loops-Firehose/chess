class PiecesController < ApplicationController

  def update
    if invalid? == true
      flash[:invalid] = "Invalid Move!"
      redirect_to @user
    end
  end

end
