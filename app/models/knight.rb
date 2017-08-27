class Knight < Piece
  def valid_move?(x_destination, y_destination)
    (x_position - x_destination.to_i).abs == 1 && (y_position - y_destination.to_i).abs == 2 ||
      (x_position - x_destination.to_i).abs == 2 && (y_position - y_destination.to_i).abs == 1
  end

  # this method can replace the piece obstructed? method when a knight is moved
  def obstructed?(new_x, new_y); end
end
