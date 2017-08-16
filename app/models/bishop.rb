class Bishop < Piece
  def valid_move?(new_x, new_y)
    unless obstructed?(new_x, new_y)
      return true if (new_x.to_i - x_position).abs == (new_y.to_i - y_position).abs
    end
    false
    super(new_x, new_y) # way to call the parent class which should run the rest of the shared code
  end

end
