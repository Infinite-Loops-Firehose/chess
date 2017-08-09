class Rook < Piece 

  def valid_move?(piece)
    if @piece.type == "ROOK"
      if @piece.horizontal_or_vertical?
        piece.horizontal_or_vertical_obstruction?
      end
    end
  end
end
