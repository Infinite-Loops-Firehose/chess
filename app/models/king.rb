class King < Piece
  def valid_move?(new_x, new_y)
    x_difference = (new_x - x_position).abs
    y_difference = (new_y - y_position).abs

    (x_difference <= 1) && (y_difference <= 1)
  end
end
