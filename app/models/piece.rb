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
    if destination_y - self.y_position == 0
      # check if obstructed
      # array = []

      
    end
  end

  def vertical?(destination_x, destination_y)
    if destination_x - self.x_position == 0
      # array = []
      # x_position, y_position +=1 
      # 1,3 --> 1,6 
      # 1,4 1,5
      # if y_position +1(1,4), +2(1,5)
    end
  end

  def diagonal?(destination_x, destination_y)
    if (destination_x - x_position).abs == (destination_y - y_position).abs    
      # check if obstructed
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
