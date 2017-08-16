# may only move one square forward unless first move
# if first move, can choose to move one square or two
# can never move backwards
# cannot move forward if square in front occupied by another piece
# captures by taking one square diagonally forward

class Pawn < Piece
  def valid_move?(new_x, new_y)
    return false if current_position?(new_x, new_y)
    return false if backwards_move?(new_y)
    return false if sideways_move?(new_x, new_y)
    return true if capture_move?(new_x, new_y)
    allowed_to_move?(new_x, new_y) && !square_occupied?(new_x, new_y)
  end

  private

  def allowed_to_move?(new_x, new_y)
    x_difference = (new_x - x_position).abs
    y_difference = (new_y - y_position).abs

    if has_moved
      x_difference.zero? && y_difference == 1
    else
      x_difference.zero? && y_difference == 1 || x_difference.zero? && y_difference == 2
    end
  end

  def capture_move?(new_x, new_y)
    x_difference = (new_x - x_position).abs
    y_difference = (new_y - y_position).abs
    capture_piece = Piece.exists?(x_position: new_x, y_position: new_y, is_white: !is_white, game: game)
    capture_piece && x_difference == 1 && y_difference == 1
  end

  def backwards_move?(new_y)
    return new_y > y_position if is_white
    new_y < y_position
  end

  def current_position?(new_x, new_y)
    x_position == new_x && y_position == new_y
  end

  def sideways_move?(new_x, new_y)
    x_difference = (x_position - new_x).abs
    x_difference != 0 && new_y == y_position
  end

  def first_move?(_new_y)
    (y_position == 7 && is_white) || (y_position == 2 && !is_white)
  end

  def en_passant?(new_y)
    y_difference = (new_y - y_position).abs
    first_move?(new_y) ? y_difference == 2 : false
  end
end
