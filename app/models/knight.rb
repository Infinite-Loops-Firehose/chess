class Knight < Piece
  def valid_move?(new_x, new_y)
    (x_position - new_x).abs == 1 && (y_position - new_y).abs == 2 ||
      (x_position - new_x).abs == 2 && (y_position - new_y).abs == 1
  end

  # this method can replace the piece obstructed? method when a knight is moved
  def obstructed?(new_x, new_y); end

end
