class Piece < ApplicationRecord
  belongs_to :game
end

PAWN='Pawn'
ROOK='Rook'
KNIGHT='Knight'
BISHOP='Bishop'
QUEEN='Queen'
KING='King'