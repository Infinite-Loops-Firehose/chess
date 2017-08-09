class Rook < Piece
  def valid_move?(x_destination, y_destination)
    (vertical(x_destination, y_destination) || horizontal(x_destination, y_destination)) && !obstructed?(x_destination, y_destination)
  end

  def vertical(x_destination, y_destination)
    (x_position == x_destination) && (y_position != y_destination)
  end

  def horizontal(x_destination, y_destination)
    (y_position == y_destination) && (x_position != x_destination)
  end
end
