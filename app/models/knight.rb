class Knight < Piece
  def valid_move?(x_destination, y_destination)
    ((x_position - x_destination).abs == 1 && (y_position - y_destination).abs == 2) ||
      ((x_position - x_destination).abs == 2 && (y_position - y_destination).abs == 1)
  end
end
