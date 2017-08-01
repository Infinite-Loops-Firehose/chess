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

  describe "get_piece_at_coor method" do
    it "returns the piece object at given square" do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: PAWN, x_position: 1, y_position: 2)
      piece_found = piece1.get_piece_at_coor(1,2)
      expect(piece_found).to eq(piece1)
    end
    it "returns nil if there is no piece at specified square" do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: KNIGHT, x_position: 7, y_position: 1)
      piece_found = piece1.get_piece_at_coor(1,1)
      expect(piece_found).to eq(nil)
    end
  end

  describe "capture_piece method" do
    it "sets piece x and y coor to nil if piece can be captured" do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: KNIGHT, x_position: 7, y_position: 1)
      piece1.capture_piece(piece1)
      expect(piece1.x_position).to eq(nil)
      expect(piece1.y_position).to eq(nil)
    end
  end

  describe "move_to! method" do
    it "Changes x and y coor of moving piece to x and y of destination square if that square is empty" do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: KING, x_position: 2, y_position: 4)
      piece1.move_to!(3,4)
      expect(piece1.x_position).to eq(3)
      expect(piece1.y_position).to eq(4)
    end
    it "updates x and y of moving piece to new square and captures enemy piece at that square" do
      game1 = FactoryGirl.create(:game)
      black_king = Piece.create(game_id: game1.id, is_white: false, type: KING, x_position: 2, y_position: 4)
      white_queen = Piece.create(game_id: game1.id, is_white: true, type: QUEEN, x_position: 1, y_position: 4)
      black_king.move_to!(1,4)
      expect(black_king.x_position).to eq(1)
      expect(black_king.y_position).to eq(4)
      white_queen.reload
      expect(white_queen.x_position).to eq(nil)
      expect(white_queen.y_position).to eq(nil)
    end
    it "raises argument error if player tries to capture or move into a friendly piece" do
      game1 = FactoryGirl.create(:game)
      black_pawn = game1.pieces.create(game_id: game1.id, is_white: false, type: PAWN, x_position: 2, y_position: 5)
      black_knight = game1.pieces.create(game_id: game1.id, is_white: false, type: KNIGHT, x_position: 3, y_position: 6)
      expect{ black_pawn.move_to!(3, 6) }.to raise_error(ArgumentError)
      black_knight.reload
      expect(black_pawn.x_position).to eq(2)
      expect(black_pawn.y_position).to eq(5)
      expect(black_knight.x_position).to eq(3)
      expect(black_knight.y_position).to eq(6)
    end
  end
end
