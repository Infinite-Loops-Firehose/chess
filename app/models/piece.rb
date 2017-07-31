class Piece < ApplicationRecord
  belongs_to :game

  def move_to!(new_x, new_y, white_turn) 
    if (is_square_occupied?(new_x, new_y))
      occupying_piece = get_piece_at_coor(new_x, new_y)
      if (occupying_piece.is_white && !white_turn) || (!occupying_piece.is_white && white_turn)
        capture_piece(occupying_piece)
        update_attributes(x_position: new_x, y_position: new_y)
      else
        raise ArgumentError.new("That is an invalid move. Cannot capture your own piece.")
      end
    else
      update_attributes(x_position: new_x, y_position: new_y)
    end
  end

  def is_square_occupied?(new_x, new_y)
    Piece.all.each do |piece|
      if piece.x_position == new_x && piece.y_position == new_y
        return true
      end
    end
    return false
  end

  def get_piece_at_coor(x, y)
    Piece.all.each do|piece|
      if piece.x_position == x && piece.y_position == y
        return piece
      end
    end
    return nil
  end

  def capture_piece(piece_captured)
    piece_captured.update_attributes(x_position: nil, y_position: nil)
  end
end

PAWN = 'Pawn'.freeze
ROOK = 'Rook'.freeze
KNIGHT = 'Knight'.freeze
BISHOP = 'Bishop'.freeze
QUEEN = 'Queen'.freeze
KING = 'King'.freeze
