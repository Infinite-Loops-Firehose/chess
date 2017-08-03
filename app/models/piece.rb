class Piece < ApplicationRecord
  belongs_to :game

  def self.color
    # needs to be fixed so is_white acts like the attribute it is, and not a method.
    return "White" if is_white == true  
    return "Black" if is_white == false
  end

  def self.render
    return "#{color} #{type}"
  end

end

  PAWN = 'Pawn'.freeze
  ROOK = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN = 'Queen'.freeze
  KING = 'King'.freeze