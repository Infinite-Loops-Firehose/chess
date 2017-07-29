class Piece < ApplicationRecord
  belongs_to :game

  PAWN = 'Pawn'.freeze
  ROOK = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN = 'Queen'.freeze
  KING = 'King'.freeze

  def obstructed?(destination_x, destination_y)
    return true if horizontal_or_vertical_obstruction?(destination_x, destination_y)
    return true if diagonal_obstruction?(destination_x, destination_y)
    return true if invalid?(destination_x, destination_y)

    false
  end

  def horizontal_or_vertical_obstruction?(destination_x, destination_y)
    return false unless destination_x == x_position || destination_y == y_position
    range_x = [destination_x, x_position].sort
    range_y = [destination_y, y_position].sort
    obstruction = Piece.where(y_position: ((range_y.first + 1)..(range_y.last - 1)), x_position: ((range_x.first + 1)..(range_x.last - 1))) # will always return something, even if it's an empty query
    obstruction.present? # should return false if the query is empty
  end

  def diagonal_obstruction?(destination_x, destination_y)
    x_vector = destination_x - x_position # gets the distance and the direction of the horizontal move.
    # positive is to the right, negative is to the left.
    y_vector = destination_y - y_position # gets the distance and the direction of the vertical move.
    # positive is up, negative is down.
    return false unless x_vector.abs == y_vector.abs # in order for the move to be diagonal, the piece must be moving by the same distance both horizontally and vertically.
    x_values = (x_position..destination_x).to_a # array of x values, including the starting and ending squares
    y_values = (y_position..destination_y).to_a # array of y values, including the starting and ending squares
    coordinates = [] # is it necessary to declare this array first before pushing to it?

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
