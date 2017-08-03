class Piece < ApplicationRecord
  # class OffBoardError < StandardError; end   <-- we may want to use this at some point for error messages

  belongs_to :game

  PAWN = 'Pawn'.freeze
  ROOK = 'Rook'.freeze
  KNIGHT = 'Knight'.freeze
  BISHOP = 'Bishop'.freeze
  QUEEN = 'Queen'.freeze
  KING = 'King'.freeze

  def obstructed?(destination_x, destination_y)
    errors.add(:off_board, "Pieces cannot be moved off the board: invalid move") if invalid?(destination_x, destination_y)
    errors.add(:horizontal_or_vertical_obstruction, "There is a horizontal or vertical obstruction: invalid move") if horizontal_or_vertical_obstruction?(destination_x, destination_y)
    errors.add(:diagonal_obstruction, "There is a diagonal obstruction: invalid move") if diagonal_obstruction?(destination_x, destination_y)
    return errors.present?
  end

  private

  def invalid?(destination_x, destination_y)
    return true if destination_x < 1 || destination_x > 8 || destination_y < 1 || destination_y > 8
  end

  def horizontal_or_vertical?(destination_x, destination_y)
    destination_x == x_position || destination_y == y_position
  end

  def diagonal?(destination_x, destination_y)
    # in order for the move to be diagonal, the piece must be moving by the same distance both horizontally and vertically.
    return true if (destination_x - x_position).abs == (destination_y - y_position).abs
  end


  def vertical_obstruction?(range_y)
    obstruction = game.pieces.where(y_position: ((range_y.first + 1)..(range_y.last - 1)), x_position: x_position) # will always return something, even if it's an empty query
    obstruction.present?
  end

  def horizontal_obstruction?(range_x)
    obstruction = game.pieces.where(y_position: y_position, x_position: (range_x.first + 1)..(range_x.last - 1)) # will always return something, even if it's an empty query
    obstruction.present?
  end

  def horizontal_or_vertical_obstruction?(destination_x, destination_y)
    return false unless horizontal_or_vertical?(destination_x, destination_y)
    range_x = [destination_x, x_position].sort
    range_y = [destination_y, y_position].sort
    vertical_obstruction?(range_y) || horizontal_obstruction?(range_x)

    # obstruction = game.pieces.where(y_position: ((range_y.first + 1)..(range_y.last - 1)), x_position: ((range_x.first + 1)..(range_x.last - 1))) # will always return something, even if it's an empty query
    # obstruction.present? # should return false if the query is empty
  end

  def diagonal_obstruction?(destination_x, destination_y)
    return false unless diagonal?(destination_x, destination_y)

    # [
    #   [1, 6],
    #   [2, 5],
    #   [3, 4]
    # ]
    #
    # (r.first).downto(r.last).to_a
    x_values = if x_position < destination_x
                 (x_position..destination_x).to_a # array of x values, including the starting and ending squares
               else
                 x_position.downto(destination_x).to_a
               end

    y_values = if y_position < destination_y
                 (y_position..destination_y).to_a # array of y values, including the starting and ending squares
               else
                 y_position.downto(destination_y).to_a
               end

    coordinates = []

    x_values.zip(y_values) do |x_value, y_value| # combines x_value and y_value pairs into a multidimensional array
      coordinates << [x_value, y_value] # [ [1, 1], [2, 2], [3, 3] ] for example
    end

    coordinates.shift
    coordinates.pop # this is an array of only the in-between squares - not including the start or end squares
    sql = coordinates.map do |coordinate| # sql = [[2,2],[3,3]]
      "x_position = #{coordinate.first} AND y_position = #{coordinate.last}"
    end.join(' or ') # "x_position = 1 and y_position = 1 or x_position = 2 and y_position = 2 or ..."

    obstruction = game.pieces.where(sql)
    obstruction.present?
  end
end
