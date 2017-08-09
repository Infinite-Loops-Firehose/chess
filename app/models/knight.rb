class Knight < Piece

  def valid_move?(x_destination, y_destination)
    (x_destination == (x_position - 1 || x_position + 1)) && (y_destination == (y_position + 2 || y_position -2))
    (x_destination == (x_position - 2 || x_position + 2)) && (y_destination == (y_position + 1 || y_position -1))
  end

end
