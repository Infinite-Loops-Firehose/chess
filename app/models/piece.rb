class Piece < ApplicationRecord
  belongs_to :game

  PAWN = 'Pawn'.freeze
  ROOK = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN = 'Queen'.freeze
  KING = 'King'.freeze

  def color
    # needs to be fixed so is_white acts like the attribute it is, and not a method.
    return 'White' if is_white == true
    return 'Black' if is_white == false
  end

  def render
    "#{color} #{type}"
  end
end
