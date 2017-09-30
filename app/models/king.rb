class King < Piece
  def valid_move?(new_x, new_y)
    return false if off_board?(new_x, new_y)
    if square_occupied?(new_x, new_y)
      return false if game.get_piece_at_coor(new_x, new_y).is_white == is_white
    end
    x_difference = (new_x.to_i - x_position).abs
    y_difference = (new_y.to_i - y_position).abs

    (x_difference <= 1) && (y_difference <= 1)
  end

  def can_move_out_of_check?
    ((x_position - 1)..(x_position + 1)).each do |x|
      ((y_position - 1)..(y_position + 1)).each do |y|
        return true if valid_move?(x, y) &&
                       game.under_attack?(is_white, x, y) == false &&
                       (game.attacking_piece(is_white).type != 'knight' ? game.attacking_piece(is_white).straight_move?(x, y) == false : true)
      end
    end
    false
  end
end
