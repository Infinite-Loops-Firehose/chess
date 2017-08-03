class King < Piece
  def valid_move?(destination_x, destination_y)
    x_difference = (destination_x - x_position).abs
    y_difference = (destination_y - y_position).abs

    (x_difference <= 1) && (y_difference <= 1) ? true : false
  end
end
