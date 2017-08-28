require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#populate_board!' do
    it 'creates 32 pieces on the board' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.count).to eq(32)
    end

    it 'creates correct number of pawns' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_pawns = game.pieces.where(type: PAWN, is_white: true).count
      expect(n_white_pawns).to eq(8)
      n_black_pawns = game.pieces.where(type: PAWN, is_white: false).count
      expect(n_black_pawns).to eq(8)
    end

    it 'creates correct number of rooks' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_rooks = game.pieces.where(type: ROOK, is_white: true).count
      expect(n_white_rooks).to eq(2)
      n_black_rooks = game.pieces.where(type: ROOK, is_white: false).count
      expect(n_black_rooks).to eq(2)
    end

    it 'creates correct number of knights' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_knights = game.pieces.where(type: KNIGHT, is_white: true).count
      expect(n_white_knights).to eq(2)
      n_black_knights = game.pieces.where(type: KNIGHT, is_white: false).count
      expect(n_black_knights).to eq(2)
    end

    it 'creates the correct number of bishops' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_bishops = game.pieces.where(type: BISHOP, is_white: true).count
      expect(n_white_bishops).to eq(2)
      n_black_bishops = game.pieces.where(type: BISHOP, is_white: false).count
      expect(n_black_bishops).to eq(2)
    end

    it 'creates one queen for each side' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_queens = game.pieces.where(type: QUEEN, is_white: true).count
      expect(n_white_queens).to eq(1)
      n_black_queens = game.pieces.where(type: QUEEN, is_white: false).count
      expect(n_black_queens).to eq(1)
    end

    it 'creates one king for each side' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_kings = game.pieces.where(type: KING, is_white: true).count
      expect(n_white_kings).to eq(1)
      n_black_kings = game.pieces.where(type: KING, is_white: false).count
      expect(n_black_kings).to eq(1)
    end
  end

  describe '#render_piece' do
    it 'shows the correct color and type' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:piece, game_id: game.id, type: PAWN, is_white: true, x_position: 1, y_position: 1)
      expect(game.render_piece(1, 1)).to eq('White Pawn')
    end

    it 'renders nothing if there isn\'t a piece present' do
      game = FactoryGirl.create(:game)
      expect(game.render_piece(1, 1)).to eq(nil)
    end
  end

  describe '#check?' do
    it 'should return true if king in check' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 3, y_position: 8)
      FactoryGirl.create(:bishop, is_white: false, game: game, x_position: 6, y_position: 5)
      expect(game.check?(true)).to eq(true)
    end

    it 'should return false if king is not in check' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 3, y_position: 8)
      FactoryGirl.create(:bishop, is_white: false, game: game, x_position: 7, y_position: 5)
      expect(game.check?(true)).to eq(false)
    end
  end

  describe '#stalemate?' do
    it 'returns true if king is trapped in corner' do
      game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, is_white: true, game: game, x_position: 8, y_position: 1)
      FactoryGirl.create(:rook, is_white: false, game: game, x_position: 5, y_position: 2)
      FactoryGirl.create(:bishop, is_white: false, game: game, x_position: 7, y_position: 1)
      FactoryGirl.create(:knight, is_white: false, game: game, x_position: 6, y_position: 3)
      expect(game.stalemate?(white_king.is_white)).to eq(true)
    end

    it 'returns true if king is trapped in center of board' do
      game = FactoryGirl.create(:game)
      black_king = FactoryGirl.create(:king, is_white: false, game: game, x_position: 5, y_position: 4)
      FactoryGirl.create(:pawn, is_white: false, game: game, x_position: 4, y_position: 4)
      FactoryGirl.create(:pawn, is_white: false, game: game, x_position: 6, y_position: 4)
      FactoryGirl.create(:pawn, is_white: false, game: game, x_position: 5, y_position: 3)
      FactoryGirl.create(:rook, is_white: false, game: game, x_position: 4, y_position: 3)
      FactoryGirl.create(:bishop, is_white: true, game: game, x_position: 2, y_position: 1)
      FactoryGirl.create(:knight, is_white: true, game: game, x_position: 2, y_position: 4)
      FactoryGirl.create(:rook, is_white: true, game: game, x_position: 3, y_position: 4)
      FactoryGirl.create(:rook, is_white: true, game: game, x_position: 4, y_position: 6)
      FactoryGirl.create(:pawn, is_white: true, game: game, x_position: 3, y_position: 5)
      FactoryGirl.create(:pawn, is_white: true, game: game, x_position: 5, y_position: 5)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 6, y_position: 6)
      FactoryGirl.create(:pawn, is_white: true, game: game, x_position: 6, y_position: 3)
      FactoryGirl.create(:piece, is_white: true, type: QUEEN, game: game, x_position: 7, y_position: 4)
      FactoryGirl.create(:bishop, is_white: true, game: game, x_position: 8, y_position: 1)
      expect(game.stalemate?(black_king.is_white)).to eq(true)
    end

    it 'returns false if valid move can be made that does not put king in check' do
      game = FactoryGirl.create(:game)
      black_king = FactoryGirl.create(:king, is_white: false, game: game, x_position: 5, y_position: 4)
      FactoryGirl.create(:rook, is_white: false, game: game, x_position: 2, y_position: 5)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 1, y_position: 8)
      FactoryGirl.create(:rook, is_white: true, game: game, x_position: 2, y_position: 6)
      expect(game.stalemate?(black_king.is_white)).to eq(false)
    end

    it 'returns false if king is currently in check' do
      game = FactoryGirl.create(:game)
      white_king = FactoryGirl.create(:king, is_white: true, game: game, x_position: 4, y_position: 7)
      FactoryGirl.create(:rook, is_white: false, game: game, x_position: 4, y_position: 5)
      FactoryGirl.create(:king, is_white: false, game: game, x_position: 5, y_position: 2)
      expect(game.stalemate?(white_king.is_white)).to eq(false)
    end
  end
end
