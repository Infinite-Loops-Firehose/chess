# may only move one square forward unless first move
# if first move, can choose to move one square or two
# can never move backwards
# cannot move forward if square in front occupied by another piece
# captures by taking one square diagonally forward

class Pawn < Piece
  def valid_move?(new_x, new_y)
    return false if current_position?(new_x.to_i, new_y.to_i)
    return false if backwards_move?(new_y.to_i)
    return false if sideways_move?(new_x.to_i, new_y.to_i)
    return true if capture_move?(new_x.to_i, new_y.to_i)
    allowed_to_move?(new_x.to_i, new_y.to_i) && !square_occupied?(new_x.to_i, new_y.to_i)
  end

  def moving_two_squares?(new_x, new_y)
    x_difference = (new_x.to_i - x_position).abs
    y_difference = (new_y.to_i - y_position).abs
    x_difference.zero? && y_difference == 2
  end

  private

  def allowed_to_move?(new_x, new_y)
    x_difference = (new_x - x_position).abs
    y_difference = (new_y - y_position).abs
    if has_moved
      x_difference.zero? && y_difference == 1
    else
      (x_difference.zero? && y_difference == 1) || (x_difference.zero? && y_difference == 2)
    end
    
  end

  def capture_move?(new_x, new_y)
    x_difference = (new_x - x_position).abs
    y_difference = (new_y - y_position).abs
    enemy_in_dest = Piece.exists?(x_position: new_x, y_position: new_y, is_white: !is_white, game: game)
    if enemy_in_dest && x_difference == 1 && y_difference == 1
      return true
    end
    adjacent_enemy_pawn = Pawn.find_by(x_position: new_x, y_position: y_position, is_white: !is_white, game: game)
    unless adjacent_enemy_pawn.present?
      return false
    end
    unless adjacent_enemy_pawn.turn_pawn_moved_twice == game_move_number - 1
      return false
    end
    unless y_position == 5 || y_position == 4
      return false
    end
    capture_piece(adjacent_enemy_pawn)
    return true
  end

  def backwards_move?(new_y)
    return new_y > y_position if is_white
    new_y < y_position
  end

  def current_position?(new_x, new_y)
    puts new_x
    puts new_y
    puts x_position
    puts y_position
    x_position == new_x && y_position == new_y
  end

  def sideways_move?(new_x, new_y)
    x_difference = (x_position - new_x).abs
    x_difference != 0 && new_y == y_position
  end
end
