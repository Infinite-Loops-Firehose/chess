require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return true when moving one space forward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, is_white: true)
      expect(pawn.valid_move?(4, 3)).to eq true
    end

    it 'should return true when moving two spaces forward on first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, has_moved: false, is_white: true)
      expect(pawn.valid_move?(4, 4)).to eq true
    end

    it 'should return false if moving to same position' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2)
      expect(pawn.valid_move?(4, 2)).to eq false
    end

    it 'should return false if moving three spaces forward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2)
      expect(pawn.valid_move?(4, 5)).to eq false
    end

    it 'should return false if moving two spaces forward after first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 3, has_moved: true)
      expect(pawn.valid_move?(4, 5)).to eq false
    end

    it 'should return false if moving one space backward' do
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 6, is_white: false)
      expect(pawn.valid_move?(5, 7)).to eq false
    end

    it 'should return false if moving one space backward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, is_white: true)
      expect(pawn.valid_move?(4, 1)).to eq false
    end

    it 'should return false if moving one space horizontally' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4)
      expect(pawn.valid_move?(5, 4)).to eq false
    end

    it 'should return true if moving one space diagonally forward when capturing' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:rook, x_position: 4, y_position: 4, is_white: true, game: game)
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 5, is_white: false, has_moved: true, game: game)
      expect(pawn.valid_move?(4, 4)).to eq true
    end

    it 'should return false if moving more than one space diagonally forward when capturing' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:rook, x_position: 2, y_position: 2, is_white: true, game: game)
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 5, is_white: false, has_moved: true, game: game)
      expect(pawn.valid_move?(2, 2)).to eq false
    end

    it 'should return false if moving one space diagonally forward when not capturing' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4, game: game)
      expect(pawn.valid_move?(5, 5)).to eq false
    end

    it 'should return false if moving one space forward when destination square is occupied' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4, is_white: false, game: game)
      FactoryGirl.create(:rook, x_position: 4, y_position: 3, is_white: true, game: game)
      expect(pawn.valid_move?(4, 3)).to eq false
    end

    it 'should return true when capturing piece using en passant' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:king, x_position: 5, y_position: 8, is_white: false, game: game)
      pawn_captured = FactoryGirl.create(:pawn, x_position: 5, y_position: 7, is_white: false, game: game)
      pawn_captured.move_to!(5, 5)
      pawn_moved = FactoryGirl.create(:pawn, x_position: 4, y_position: 5, is_white: true, game: game)
      expect(pawn_moved.valid_move?(5, 6)).to eq true
    end
  end

  describe 'en_passant_capture?' do
    it 'should set database coordinates of captured piece to nil' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:king, x_position: 5, y_position: 8, is_white: true, game: game)
      FactoryGirl.create(:king, x_position: 5, y_position: 1, is_white: false, game: game)
      pawn_captured = FactoryGirl.create(:pawn, x_position: 5, y_position: 7, is_white: false, game: game)
      pawn_moved = FactoryGirl.create(:pawn, x_position: 4, y_position: 5, is_white: true, game: game)
      pawn_captured.move_to!(5, 5)
      pawn_moved.move_to!(5, 6)
      pawn_captured.reload
      expect(pawn_captured.x_position).to eq nil
      expect(pawn_captured.y_position).to eq nil
    end

    it 'should set coordinates of the capturing piece to behind captured piece' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:king, x_position: 5, y_position: 8, is_white: true, game: game)
      FactoryGirl.create(:king, x_position: 5, y_position: 1, is_white: false, game: game)
      pawn_captured = FactoryGirl.create(:pawn, x_position: 5, y_position: 7, is_white: false, game: game)
      pawn_captured.move_to!(5, 5)
      pawn_moved = FactoryGirl.create(:pawn, x_position: 4, y_position: 5, is_white: true, game: game)
      pawn_moved.move_to!(5, 6)
      expect(pawn_moved.x_position).to eq 5
      expect(pawn_moved.y_position).to eq 6
    end

    it 'should not allow en passant if captured piece was moved more than one turn ago' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:king, x_position: 5, y_position: 8, is_white: true, game: game)
      FactoryGirl.create(:king, x_position: 5, y_position: 1, is_white: false, game: game)
      pawn_captured = FactoryGirl.create(:pawn, x_position: 5, y_position: 7, is_white: false, game: game)
      pawn_captured.move_to!(5, 5)
      pawn_moved = FactoryGirl.create(:pawn, x_position: 4, y_position: 4, is_white: true, game: game)
      pawn_moved.move_to!(4, 5)
      pawn_captured.reload
      pawn_moved.reload
      expect(pawn_captured.vul_to_en_passant?).to eq(false)
    end
  end
end
