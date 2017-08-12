require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return true when moving one space forward' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, game: game)
      expect(pawn.valid_move?(4, 3)).to eq true
    end

    it 'should return true when moving two spaces forward on first move' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, has_moved: false, game: game)
      expect(pawn.valid_move?(4, 4)).to eq true
    end

    it 'should return false if moving to same position' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, game: game)
      expect(pawn.valid_move?(4, 2)).to eq false
    end

    it 'should return false if moving three spaces forward' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, game: game)
      expect(pawn.valid_move?(4, 5)).to eq false
    end

    it 'should return false if moving two spaces forward after first move' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 3, has_moved: true, game: game)
      expect(pawn.valid_move?(4, 5)).to eq false
    end

    it 'should return false if moving one space backward' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 6, is_white: true, game: game)
      expect(pawn.valid_move?(5, 7)).to eq false
    end

    it 'should return false if moving one space backward' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, is_white: false, game: game)
      expect(pawn.valid_move?(4, 1)).to eq false
    end

    it 'should return false if moving one space horizontally' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4, game: game)
      expect(pawn.valid_move?(5, 4)).to eq false
    end

    it 'should return true if moving one space diagonally forward when capturing' do
      game = FactoryGirl.create(:game)
      rook = FactoryGirl.create(:rook, x_position: 4, y_position: 4, is_white: false, game: game)
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 5, is_white: true, has_moved: true, game: game)
      expect(pawn.valid_move?(4, 4)).to eq true
    end

    it 'should return false if moving more than one space diagonally forward when capturing' do
      game = FactoryGirl.create(:game)
      rook = FactoryGirl.create(:rook, x_position: 2, y_position: 2, is_white: false, game: game)
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 5, is_white: true, has_moved: true, game: game)
      expect(pawn.valid_move?(2, 2)).to eq false
    end

    it 'should return false if moving one space diagonally forward when not capturing' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4, game: game)
      expect(pawn.valid_move?(5, 5)).to eq false
    end

    it 'should return false if moving one space forward when destination square is occupied' do
      game = FactoryGirl.create(:game)
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4, is_white: true, game: game)
      rook = FactoryGirl.create(:rook, x_position: 4, y_position: 5, is_white: false, game: game)
      expect(pawn.valid_move?(4, 5)).to eq false
    end
  end
end
