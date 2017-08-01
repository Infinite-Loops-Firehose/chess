class Piece < ApplicationRecord
  belongs_to :game

  def move_to!(new_x, new_y)
    unless is_square_occupied?(new_x, new_y)
      update_attributes(x_position: new_x, y_position: new_y)
      return
    end
    occupying_piece = get_piece_at_coor(new_x, new_y)
    unless (occupying_piece.is_white && self.is_white?) || (!occupying_piece.is_white && !is_white?)
      capture_piece(occupying_piece)
      update_attributes(x_position: new_x, y_position: new_y)
      return
    end
    raise ArgumentError.new("That is an invalid move. Cannot capture your own piece.")
  end

  def is_square_occupied?(new_x, new_y)
    piece = game.pieces.find_by(x_position: new_x, y_position: new_y)
    if (piece == nil)
      return false
    else
      return true
    end
  end

  def get_piece_at_coor(x, y)
    Piece.all.each do|piece|
      if piece.x_position == x && piece.y_position == y
        return piece
      end
    end
    nil
  end

  def capture_piece(piece_captured)
    piece_captured.update(x_position: nil, y_position: nil)
  end
end

PAWN = 'Pawn'.freeze
ROOK = 'Rook'.freeze
KNIGHT = 'Knight'.freeze
BISHOP = 'Bishop'.freeze
QUEEN = 'Queen'.freeze
KING = 'King'.freeze
