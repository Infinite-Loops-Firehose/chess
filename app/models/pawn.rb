# may only move one square forward unless first move
# if first move, can choose to move one square or two
# can never move backwards
# cannot move forward if square in front occupied by another piece
# captures by taking one square diagonally forward

class Pawn < Piece
  def valid_move?(destination_x, destination_y)
    return false if current_position?(destination_x, destination_y)
    return false if backwards_move?(destination_y)
    return false if sideways_move?(destination_x, destination_y)
    return true if capture_move?(destination_x, destination_y)
    allowed_to_move?(destination_x, destination_y) && !square_occupied?(destination_x, destination_y)
  end

  private

  def allowed_to_move?(destination_x, destination_y)
    x_difference = (destination_x - x_position).abs
    y_difference = (destination_y - y_position).abs

    if has_moved
      x_difference.zero? && y_difference == 1
    else
      x_difference.zero? && y_difference == 1 || x_difference.zero? && y_difference == 2
    end
  end

  def capture_move?(destination_x, destination_y)
    x_difference = (destination_x - x_position).abs
    y_difference = (destination_y - y_position).abs
    capture_piece = Piece.exists?(x_position: destination_x, y_position: destination_y, is_white: !is_white, game: game)
    capture_piece && x_difference == 1 && y_difference == 1
  end

  def backwards_move?(destination_y)
    return destination_y > y_position if is_white
    destination_y < y_position
  end

  def current_position?(destination_x, destination_y)
    x_position == destination_x && y_position == destination_y
  end

  def sideways_move?(destination_x, destination_y)
    x_difference = (x_position - destination_x).abs
    x_difference != 0 && destination_y == y_position
  end
end
