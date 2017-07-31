class Piece < ApplicationRecord
  belongs_to :game

  PAWN = 'Pawn'.freeze
  ROOK = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN = 'Queen'.freeze
  KING = 'King'.freeze

  def obstructed?(destination_x, destination_y)
    return true if self.invalid?(destination_x, destination_y)
    return true if self.horizontal_or_vertical_obstruction?(destination_x, destination_y)
    return true if self.diagonal_obstruction?(destination_x, destination_y)
    false
  end

  def horizontal_or_vertical?(destination_x, destination_y)
    return false unless destination_x == self.x_position || destination_y == self.y_position
  end

  def diagonal?(destination_x, destination_y)
    # in order for the move to be diagonal, the piece must be moving by the same distance both horizontally and vertically.
    return false unless (destination_x - self.x_position).abs == (destination_y - self.y_position).abs
  end

  def invalid?(destination_x, destination_y)
    return true if !destination_x.is_i? || !destination_y.is_i?
    return true if destination_x < 1 || destination_x > 8 || destination_y < 1 || destination_y > 8
    return true if !self.horizontal_or_vertical?(destination_x, destination_y)
    return true if !self.diagonal?(destination_x, destination_y)
    false
  end

  def horizontal_or_vertical_obstruction?(destination_x, destination_y)
    return false unless self.horizontal_or_vertical?(destination_x, destination_y)
    range_x = [destination_x, self.x_position].sort
    range_y = [destination_y, self.y_position].sort
    obstruction = Piece.where(y_position: ((range_y.first + 1)..(range_y.last - 1)), x_position: ((range_x.first + 1)..(range_x.last - 1))) # will always return something, even if it's an empty query
    obstruction.present? # should return false if the query is empty
  end

  def diagonal_obstruction?(destination_x, destination_y)
    return false unless self.diagonal?(destination_x, destination_y)
    x_values = (self.x_position..destination_x).to_a # array of x values, including the starting and ending squares
    y_values = (self.y_position..destination_y).to_a # array of y values, including the starting and ending squares
    coordinates = []

    x_values.zip(y_values) do |x_value, y_value| # combines x_value and y_value pairs into a multidimensional array
      coordinates << [x_value, y_value] # [ [1, 1], [2, 2], [3, 3] ] for example
    end

    coordinates.shift
    coordinates.pop # this is an array of only the in-between squares - not including the start or end squares
    sql = coordinates.map do |coordinate| # sql = [[2,2],[3,3]]
      "x_position = #{coordinate.first} AND y_position = #{coordinate.last}"
    end.join(' or ') # "x_position = 1 and y_position = 1 or x_position = 2 and y_position = 2 or ..."

    obstruction = Piece.where(sql)
    obstruction.present?
  end
end
