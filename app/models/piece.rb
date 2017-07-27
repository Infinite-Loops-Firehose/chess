class Piece < ApplicationRecord
  belongs_to :game

  def obstructed?(destination_x, destination_y)
#    starting_point = [self.x_position, self.y_position]
#    ending_point = [destination_x, destination_y]
    if horizontal?(starting_point, ending_point) || vertical?(starting_point, ending_point) || diagonal?(starting_point, ending_point) || invalid?(starting_point, ending_point)
      return true
    else
      return false
    end
  end

  def horizontal?(destination_x, destination_y)
    obstruction = nil
    if destination_y - self.y_position == 0
      if destination_x > self.x_position
        obstruction = Piece.where('y_position = ? AND x_position < ? AND x_position > ?', self.y_position, destination_x, self.x_position)
      else
        obstruction = Piece.where('y_position = ? AND x_position > ? AND x_position < ?', self.y_position, destination_x, self.x_position)
      end
    end
    if obstruction != nil
      return true
    else
      return false
    end
  end

  def vertical?(destination_x, destination_y)
    obstruction = nil
    if destination_x - self.x_position == 0
      if destination_y > self.y_position
        obstruction = Piece.where('x_position = ? AND y_position < ? AND y_position > ?', self.x_position, destination_y, self.y_position)
      else
        obstruction = Piece.where('x_position = ? AND y_position > ? AND y_position < ?', self.x_position, destination_y, self.y_position)
      end
    end
    if obstruction != nil
      return true
    else
      return false
    end
  end

  def diagonal?(destination_x, destination_y)
    obstruction = nil
    x_vector = destination_x - self.x_position #gets the distance and the direction of the horizontal move.
    # positive is to the right, negative is to the left.
    y_vector = destination_y - self.y_position #gets the distance and the direction of the vertical move.
    # positive is up, negative is down.
    if x_vector.abs == y_vector.abs #in order for the move to be diagonal, 
    # the piece must be moving by the same distance both horizontally and vertically.
      obstruction = nil
      
      obstruction = Piece.where('(? - x_position).abs == (? - y_position).abs', x_destination, y_destination)
#      if x_vector > 0 && y_vector > 0 #right up
#      elsif x_vector < 0 && y_vector > 0 #left up

#      elsif x_vector > 0 && y_vector < 0 #right down

#      elsif x_vector < 0 && y_vector < 0 #left down

#      else
        
      end
       
        
        Piece.where('x_position > ? AND y_position < ?', x_destination, y_destination) #left up
        Piece.where('x_position < ? AND y_position > ?', x_destination, y_destination) #right down
        Piece.where('x_position > ? AND y_position > ?', x_destination, y_destination) #left down

#params = ["1", "2"]
#Model.where("id = ? OR id = ?", *params)
    end
  end

  def invalid?(destination_x, destination_y)
#  checking to see if piece is moving enough to even have an obstruction    
#  if destination_x - x_position <= 1 || destination_y - y_position <= 1?
#  if not horizontal, vertical, or diagonal?
    
  end
end

chessboard = [ 
  [1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0],
  [1, 1, 1, 1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1, 1, 1, 1]
]

#where 1 = occupied, 0 = unoccupied

# create an initial blank chessboard - all 0's
# loop through all the pieces
# for all pieces, take their location and change the location in that empty chessboard to 1 (occupied)

# look at each square in between the starting position and the destination,
# check if any of those square are occupied

# horizontal => look at the x direction only

# vertical => look at the y direction only
