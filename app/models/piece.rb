class Piece < ApplicationRecord
  belongs_to :game
end

class Pawn < Piece; end
class Knight < Piece; end
class Bishop < Piece; end
class Rook < Piece; end
class Queen < Piece; end
class King < Piece; end
