require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_square_occupied? method" do
    it "returns true if the square your piece is moving to is occupied by another piece" do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: PAWN, x_position: 1, y_position: 2)
      occupied = piece1.is_square_occupied?(piece1.x_position, piece1.y_position)
      expect(occupied).to eq(true)
    end
    it "returns false if the square your piece is moving to is not occupied" do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: QUEEN, x_position: 1, y_position: 2)
      occupied = piece1.is_square_occupied?(2, piece1.y_position)
      expect(occupied).to eq(false)
    end
  end
end
