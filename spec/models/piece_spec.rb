require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '#obstructed?' do
    let(:game) { create :obstructed_game }

    context 'not obstructed' do
      it 'checks for vertical obstruction between A8 and A6' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 8)
        expect(piece.obstructed?(1, 6)).to eq(false)
      end

      it 'checks for horizontal obstruction between A8 and C8' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 8)
        expect(piece.obstructed?(3, 8)).to eq(false)
      end

      it 'diagonal between A6 and C4' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 6)
        expect(piece.obstructed?(3, 4)).to eq(false)
      end
    end

    context 'obstructed' do
      it 'checks for vertical obstruction between A1 and A4' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 1)
        expect(piece.obstructed?(1, 4)).to eq(true)
      end

      it 'diagonal between F1 and D3' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 6, y_position: 1)
        expect(piece.obstructed?(4, 3)).to eq(true)
      end

      it 'checks for horizontal obstruction between A8 and C8' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 8)
        expect(piece.obstructed?(5, 8)).to eq(true)
      end
    end

    context 'invalid' do
      it 'invalid move between D4 and B5' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 4, y_position: 4)
        expect(piece.obstructed?(2, 9)).to eq(true)
      end
    end
  end

  describe 'square_occupied? method' do
    it 'returns true if the square your piece is moving to is occupied by another piece' do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: PAWN, x_position: 1, y_position: 2)
      occupied = piece1.square_occupied?(piece1.x_position, piece1.y_position)
      expect(occupied).to eq(true)
    end
    it 'returns false if the square your piece is moving to is not occupied' do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: QUEEN, x_position: 1, y_position: 2)
      occupied = piece1.square_occupied?(2, piece1.y_position)
      expect(occupied).to eq(false)
    end
  end

  describe 'get_piece_at_coor method' do
    it 'returns the piece object at given square' do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: PAWN, x_position: 1, y_position: 2)
      piece_found = Piece.get_piece_at_coor(1, 2)
      expect(piece_found).to eq(piece1)
    end
    it 'returns nil if there is no piece at specified square' do
      game1 = FactoryGirl.create(:game)
      Piece.create(game_id: game1.id, is_white: false, type: KNIGHT, x_position: 7, y_position: 1)
      piece_found = Piece.get_piece_at_coor(1, 1)
      expect(piece_found).to eq(nil)
    end
  end

  describe 'capture_piece method' do
    it 'sets piece x and y coor to nil if piece can be captured' do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: KNIGHT, x_position: 7, y_position: 1)
      piece1.capture_piece(piece1)
      expect(piece1.x_position).to eq(nil)
      expect(piece1.y_position).to eq(nil)
    end
  end

  describe 'move_to! method' do
    it 'Changes x and y coor of moving piece to x and y of destination square if that square is empty' do
      game1 = FactoryGirl.create(:game)
      piece1 = Piece.create(game_id: game1.id, is_white: false, type: KING, x_position: 2, y_position: 4)
      piece1.move_to!(3, 4)
      expect(piece1.x_position).to eq(3)
      expect(piece1.y_position).to eq(4)
    end
    it 'updates x and y of moving piece to new square and captures enemy piece at that square' do
      game1 = FactoryGirl.create(:game)
      black_king = Piece.create(game_id: game1.id, is_white: false, type: KING, x_position: 2, y_position: 4)
      white_queen = Piece.create(game_id: game1.id, is_white: true, type: QUEEN, x_position: 1, y_position: 4)
      black_king.move_to!(1, 4)
      expect(black_king.x_position).to eq(1)
      expect(black_king.y_position).to eq(4)
      white_queen.reload
      expect(white_queen.x_position).to eq(nil)
      expect(white_queen.y_position).to eq(nil)
    end
    it 'raises argument error if player tries to capture or move into a friendly piece' do
      game1 = FactoryGirl.create(:game)
      black_pawn = game1.pieces.create(game_id: game1.id, is_white: false, type: PAWN, x_position: 2, y_position: 5)
      black_knight = game1.pieces.create(game_id: game1.id, is_white: false, type: KNIGHT, x_position: 3, y_position: 6)
      expect { black_pawn.move_to!(3, 6) }.to raise_error(ArgumentError)
      black_knight.reload
      expect(black_pawn.x_position).to eq(2)
      expect(black_pawn.y_position).to eq(5)
      expect(black_knight.x_position).to eq(3)
      expect(black_knight.y_position).to eq(6)
    end

    it 'raises argument error if the move is not valid for pawn' do
      game1 = FactoryGirl.create(:game)
      white_pawn = game1.pieces.create(game_id: game1.id, is_white: true, type: PAWN, x_position: 4, y_position: 2)
      expect { white_pawn.move_to!(4, 5) }.to raise_error(ArgumentError)
    end

    it 'raises argument error if the move is not valid for queen' do
      game1 = FactoryGirl.create(:game)
      white_queen = game1.pieces.create(game_id: game1.id, is_white: true, type: QUEEN, x_position: 5, y_position: 4)
      game1.pieces.create(game_id: game1.id, is_white: true, type: PAWN, x_position: 4, y_position: 3)
      game1.pieces.create(game_id: game1.id, is_white: false, type: ROOK, x_position: 6, y_position: 5)
      expect { white_queen.move_to!(7, 6) }.to raise_error(ArgumentError)
    end

    it 'raises argument error if the move is not valid for bishop' do
      game1 = FactoryGirl.create(:game)
      white_bishop = game1.pieces.create(game_id: game1.id, is_white: true, type: BISHOP, x_position: 5, y_position: 4)
      game1.pieces.create(game_id: game1.id, is_white: true, type: PAWN, x_position: 4, y_position: 3)
      game1.pieces.create(game_id: game1.id, is_white: false, type: ROOK, x_position: 6, y_position: 5)
      expect { white_bishop.move_to!(5, 7) }.to raise_error(ArgumentError)
    end
  end
end

# This method populates a board with the obstructed pieces that are in Ken's example
# https://gist.github.com/kenmazaika/92b81db9e977578c8d94
def obstructed_game
  obstructed_game = FactoryGirl.create(:game)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 1)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 2)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 6)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 8)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 2, y_position: 1)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 2, y_position: 2)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 2, y_position: 6)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 3, y_position: 4)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 3, y_position: 7)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 1)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 4)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 7)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 8)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 5, y_position: 2)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 5, y_position: 7)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 5, y_position: 8)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 1)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 2)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 7)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 8)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 1)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 2)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 7)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 8)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 1)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 2)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 6)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 7)
  FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 8)
  obstructed_game
end

# cases to test for:
# is_obstructed? A6 -> C4 => false
# is_obstructed? F1 -> D3 => true
# is_obstructed? A1 -> A4 => true
# is_obstructed? D4 -> B5 => Raise an Error Message # invalid input.  Not diagnal, horizontal, or vertical.
# is_obstructed? A8 -> A6 => false # note: this is not an obstruction.  This has a piece in the destination, but not in between the pieces.
# is_obstructed? A8 -> C8 => false
