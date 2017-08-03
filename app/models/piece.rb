class Piece < ApplicationRecord
  belongs_to :game

  # attr_reader :game_id, :is_white, :type
  # attr_accessor :x_position, :y_position

  # def initialize(game_id, is_white, type, x_position, y_position)
  #   @game_id = game_id
  #   @is_white = is_white
  #   @type = type
  #   @x_position = x_position
  #   @y_position = y_position
  # end

  def color
    # needs to be fixed so is_white acts like the attribute it is, and not a method.
    return 'White' if is_white == true
    return 'Black' if is_white == false
  end

  def render
    "#{color} #{type}"
  end
end

# PAWN = 'Pawn'.freeze
# ROOK = 'Rook'.freeze
# KNIGHT = 'Knight'.freeze
# BISHOP = 'Bishop'.freeze
# QUEEN = 'Queen'.freeze
# KING = 'King'.freeze
