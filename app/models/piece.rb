class Piece < ApplicationRecord
  belongs_to :game

  def color
    return 'White' if is_white == true
    'Black'
  end

  def render
    "#{color} #{type}"
  end

  def move_to!(new_x, new_y)
    unless square_occupied?(new_x, new_y)
      update_attributes(x_position: new_x, y_position: new_y)
      return
    end
    occupying_piece = Piece.get_piece_at_coor(new_x, new_y)
    unless (occupying_piece.is_white && is_white?) || (!occupying_piece.is_white && !is_white?)
      capture_piece(occupying_piece)
      update_attributes(x_position: new_x, y_position: new_y)
      return
    end
    raise ArgumentError, 'That is an invalid move. Cannot capture your own piece.'
  end

  def square_occupied?(new_x, new_y)
    piece = game.pieces.find_by(x_position: new_x, y_position: new_y)
    return false if piece.nil?
    true
  end

  def self.get_piece_at_coor(x, y)
    Piece.find_by(x_position: x, y_position: y)
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
