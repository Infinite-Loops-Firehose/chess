class Piece < ApplicationRecord
  belongs_to :game

# customize this method for each subclass (bishop, pawn, etc), using only what is needed for that piece's movement
  # def obstructed?(destination_x, destination_y)
  #  starting_point = [self.x_position, self.y_position]
  #  ending_point = [destination_x, destination_y]
  #   if horizontal_or_vertical_obstruction?(starting_point, ending_point) || diagonal_obstruction?(starting_point, ending_point) || invalid?(starting_point, ending_point)
  #     return true
  #   else
  #     return false
  #   end
  # end

  def horizontal_or_vertical_obstruction?(destination_x, destination_y)
    if destination_x == self.x_position || destination_y == self.y_position
      range_x = [destination_x, self.x_position].sort
      range_y = [destination_y, self.y_position].sort
      obstruction = Piece.where(y_position: ((range_y.first + 1)..(range_y.last - 1)), x_position: ((range_x.first + 1)..(range_x.last - 1))) #will always return something, even if it's an empty query
      obstruction.present? #should return false if the query is empty    
    else
      return false
    end
  end

  def diagonal_obstruction?(destination_x, destination_y)
    x_vector = destination_x - self.x_position # gets the distance and the direction of the horizontal move.
    # positive is to the right, negative is to the left.
    y_vector = destination_y - self.y_position #gets the distance and the direction of the vertical move.
    # positive is up, negative is down.
    if x_vector.abs == y_vector.abs #in order for the move to be diagonal, the piece must be moving by the same distance both horizontally and vertically.
      x_values = (self.x_position..destination_x).to_a # array of x values, including the starting and ending squares
      y_values = (self.y_position..destination_y).to_a # array of y values, including the starting and ending squares
      x_y_values = [] # is it necessary to declare this array first before pushing to it?

      x_values.zip(y_values) do |x_value, y_value| # combines x_value and y_value pairs into a multidimensional array
        x_y_values << [x_value, y_value]
      end

      coordinates = x_y_values.shift.pop # this is an array of only the in-between squares - not including the start or end squares

      sql = coordinates.map do |coordinate|
        "x_position = #{coordinate.first} and y_position = #{coordinate.last}"
      end.join(" or ")

      obstruction = Piece.where(sql)
      obstruction.present?
    else
      return false
    end
  end

  def invalid?(destination_x, destination_y)
#  checking to see if piece is moving enough to even have an obstruction    
#  if destination_x - x_position <= 1 || destination_y - y_position <= 1?
#  if not horizontal, vertical, or diagonal?
    
  end
end