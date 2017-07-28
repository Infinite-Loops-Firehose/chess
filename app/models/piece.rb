class Piece < ApplicationRecord
  belongs_to :game

# customize this method for each subclass, using only what is needed for that piece's movement
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
    range_x = [destination_x, self.x_position].sort
    range_y = [destination_y, self.y_position].sort
    obstruction = Piece.where(y_position: ((range_y.first + 1)..(range_y.last - 1)), x_position: ((range_x.first + 1)..(range_x.last - 1))) #will always return something, even if it's an empty query
    obstruction.present? #should return false if the query is empty    
  end

  # def vertical_obstruction?(destination_x, destination_y)
  #   obstruction = nil
  #   if destination_x - self.x_position == 0
  #     if destination_y > self.y_position
  #       obstruction = Piece.where('x_position = ? AND y_position < ? AND y_position > ?', self.x_position, destination_y, self.y_position)
  #     else
  #       obstruction = Piece.where('x_position = ? AND y_position > ? AND y_position < ?', self.x_position, destination_y, self.y_position)
  #     end
  #   end
  #   if obstruction.present?
  #     return true
  #   else
  #     return false
  #   end
  # end

  def diagonal_obstruction?(destination_x, destination_y)
    # obstruction = nil
    x_vector = destination_x - self.x_position #gets the distance and the direction of the horizontal move.
    # positive is to the right, negative is to the left.
    y_vector = destination_y - self.y_position #gets the distance and the direction of the vertical move.
    # positive is up, negative is down.
    # if x_vector.abs == y_vector.abs #in order for the move to be diagonal, 
    # the piece must be moving by the same distance both horizontally and vertically.

    # you could use arrays to list all the in-between squares.
    # then you can get all the x coordinates and x coordinates. Rails can query the x position and y position arrays
      
    

    # the range can be determined by the equation of your line (y = mx + b), and you can iterate over your x values
    # m is the slope (formula: y2 - y1 / x2 - x1)
    # start with the x values, then calculate the y values based on the line function
    
    x_values = (self.x_position..destination_x).to_a #array of x values, including the starting and ending squares
    y_values = (self.y_position..destination_y).to_a #array of y values, including the starting and ending squares

    x_values[1]..x_values[x_vector.abs - 1] do |x_value|

    end

    coordinates = [[2, 2], [3, 3], [4, 4]] #just an example, if our starting point is [1, 1] and our ending point is [5, 5]
    sql = coordinates.map do |coordinate|
      "x_position = #{coordinate.first} and y_position = #{coordinate.last}"
    end.join(" or ")

    obstruction = Piece.where(sql)
        

        # Piece.where('x_position > ? AND y_position < ?', x_destination, y_destination) #left up
        # Piece.where('x_position < ? AND y_position > ?', x_destination, y_destination) #right down
        # Piece.where('x_position > ? AND y_position > ?', x_destination, y_destination) #left down

    obstruction.present?
  end

  def invalid?(destination_x, destination_y)
#  checking to see if piece is moving enough to even have an obstruction    
#  if destination_x - x_position <= 1 || destination_y - y_position <= 1?
#  if not horizontal, vertical, or diagonal?
    
  end
end

# chessboard = [ 
#   [1, 1, 1, 1, 1, 1, 1, 1],
#   [1, 1, 1, 1, 1, 1, 1, 1],
#   [0, 0, 0, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 0, 0, 0],
#   [1, 1, 1, 1, 1, 1, 1, 1],
#   [1, 1, 1, 1, 1, 1, 1, 1]
# ]

#where 1 = occupied, 0 = unoccupied

# create an initial blank chessboard - all 0's
# loop through all the pieces
# for all pieces, take their location and change the location in that empty chessboard to 1 (occupied)

# look at each square in between the starting position and the destination,
# check if any of those square are occupied

# horizontal => look at the x direction only

# vertical => look at the y direction only
