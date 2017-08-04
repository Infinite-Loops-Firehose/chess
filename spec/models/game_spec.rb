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
      n_white_pawns = game.pieces.where(type: Piece::PAWN, is_white: true).count
      expect(n_white_pawns).to eq(8)
      n_black_pawns = game.pieces.where(type: Piece::PAWN, is_white: false).count
      expect(n_black_pawns).to eq(8)
    end

    it 'creates correct number of rooks' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_rooks = game.pieces.where(type: Piece::ROOK, is_white: true).count
      expect(n_white_rooks).to eq(2)
      n_black_rooks = game.pieces.where(type: Piece::ROOK, is_white: false).count
      expect(n_black_rooks).to eq(2)
    end

    it 'creates correct number of knights' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_knights = game.pieces.where(type: Piece::KNIGHT, is_white: true).count
      expect(n_white_knights).to eq(2)
      n_black_knights = game.pieces.where(type: Piece::KNIGHT, is_white: false).count
      expect(n_black_knights).to eq(2)
    end

    it 'creates the correct number of bishops' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_bishops = game.pieces.where(type: Piece::BISHOP, is_white: true).count
      expect(n_white_bishops).to eq(2)
      n_black_bishops = game.pieces.where(type: Piece::BISHOP, is_white: false).count
      expect(n_black_bishops).to eq(2)
    end

    it 'creates one queen for each side' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_queens = game.pieces.where(type: Piece::QUEEN, is_white: true).count
      expect(n_white_queens).to eq(1)
      n_black_queens = game.pieces.where(type: Piece::QUEEN, is_white: false).count
      expect(n_black_queens).to eq(1)
    end

    it 'creates one king for each side' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      n_white_kings = game.pieces.where(type: Piece::KING, is_white: true).count
      expect(n_white_kings).to eq(1)
      n_black_kings = game.pieces.where(type: Piece::KING, is_white: false).count
      expect(n_black_kings).to eq(1)
    end
  end

  describe '#render_piece' do
    it 'shows the correct color' do
      game = FactoryGirl.create(:game)


    end

    it 'shows the correct type' do
      game = FactoryGirl.create(:game)

    end
  end
end
