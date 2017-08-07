class Bishop < Piece
  def valid_move?(new_x, new_y)
    if !(1..8).include?(new_x) || !(1..8).include?(new_y) # || obstructed?(new_x, new_y)
      return true if (new_x - x_position).abs == (new_y - y_position).abs
    end
    false
  end
end
