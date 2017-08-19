require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return true when moving one space forward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2)
      expect(pawn.valid_move?(4, 3)).to eq true
    end

    it 'should return true when moving two spaces forward on first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, has_moved: false)
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
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 6, is_white: true)
      expect(pawn.valid_move?(5, 7)).to eq false
    end

    it 'should return false if moving one space backward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2, is_white: false)
      expect(pawn.valid_move?(4, 1)).to eq false
    end

    it 'should return false if moving one space horizontally' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4)
      expect(pawn.valid_move?(5, 4)).to eq false
    end

    it 'should return true if moving one space diagonally forward when capturing' do
      game = FactoryGirl.create(:game)
      FactoryGirl.create(:rook, x_position: 4, y_position: 4, is_white: false, game: game)
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 5, is_white: true, has_moved: true, game: game)
      expect(pawn.valid_move?(4, 4)).to eq true
    end

    it 'should return false if moving more than one space diagonally forward when capturing' do
      FactoryGirl.create(:rook, x_position: 2, y_position: 2, is_white: false)
      pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 5, is_white: true, has_moved: true)
      expect(pawn.valid_move?(2, 2)).to eq false
    end

    it 'should return false if moving one space diagonally forward when not capturing' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4)
      expect(pawn.valid_move?(5, 5)).to eq false
    end

    it 'should return false if moving one space forward when destination square is occupied' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4, is_white: true)
      FactoryGirl.create(:rook, x_position: 4, y_position: 5, is_white: false)
      expect(pawn.valid_move?(4, 5)).to eq false
    end
    
    context 'en-passant?' do
      it 'should return true if there is an enemy pawn sharing the same y_position and in an adjacent x_position that has just moved 2 spaces last turn' do
    
      end
    end
  end
end
