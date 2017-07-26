class Piece < ApplicationRecord
  belongs_to :game

  def obstructed?(destination_x, destination_y)
    if horizontal?(destination_x, destination_y) || vertical?(destination_x, destination_y) || diagonal?(destination_x, destination_y) || invalid?(destination_x, destination_y)
      return true
    else
      return false
    end
  end

  def horizontal?(destination_x, destination_y)

  end

  def vertical?(destination_x, destination_y)

  end

  def diagonal?(destination_x, destination_y)

  end

  def invalid?(destination_x, destination_y)
    
  end
end
