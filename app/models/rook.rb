class Rook < Piece
  def valid_move?(x_destination, y_destination)
    (vertical(x_destination.to_i, y_destination.to_i) || horizontal(x_destination.to_i, y_destination.to_i)) && !obstructed?(x_destination.to_i, y_destination.to_i)
  end

  private

  def vertical(x_destination, y_destination)
    (x_position == x_destination) && (y_position != y_destination)
  end

  def horizontal(x_destination, y_destination)
    (y_position == y_destination) && (x_position != x_destination)
  end
end
