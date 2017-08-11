# may only move one square forward unless first move
# if first move, can choose to move one square or two
# can never move backwards
# cannot move forward if square in front occupied by another piece
# captures by taking one square diagonally forward

class Pawn < Piece
  def valid_move?(destination_x, destination_y)
    return false if backwards_move?(destination_y)
    return false if horizontal_move?(destination_x)
    allowed_to_move?(destination_x, destination_y) && !square_occupied?(destination_x, destination_y)
  end

  private

    def allowed_to_move?(destination_x, destination_y)
      x_difference = (destination_x - x_position).abs
      y_difference = (destination_y - y_position).abs

      if has_moved
        x_difference == 0 && y_difference == 1
      else
        x_difference == 0 && y_difference == 1 || x_difference == 0 && y_difference == 2
      end
    end

    def capture_move?(destination_x, destination_y)
      # if x difference and y difference == 1 && occupying_piece is opposite color
      # move and capture piece
      captured_piece = Piece.where(x_position: destination_x, y_position: destination_y)
      return false if captured_piece.nil?
      return false if captured_piece.color == color
      diagonal?(destination_x, destination_y) && captured_piece
    end

    def backwards_move?(destination_y)
      destination_y < y_position
    end

    def horizontal_move?(destination_x)
      x_difference = (x_position - destination_x).abs
      x_difference != 0
    end
end
