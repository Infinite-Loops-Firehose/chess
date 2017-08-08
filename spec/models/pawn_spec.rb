require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return true if moving one space forward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2)
      expect(pawn.valid_move?(4, 3)).to eq true
    end

    it 'should return true when moving two spaces forward on first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2)
      expect(pawn.valid_move?(4, 4)).to eq true
    end

    it 'should return false if moving three spaces forward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 2)
      expect(pawn.valid_move?(4, 5)).to eq true
    end

    it 'should return false if moving two spaces forward after first move' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 3)
      expect(pawn.valid_move?(4, 5)).to eq true
    end

    it 'should return false if moving one space backward' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4)
      expect(pawn.valid_move?(4, 3)).to eq true
    end

    it 'should return true if moving one space diagonally forward when capturing' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4)
      expect(pawn.valid_move?(5, 5)).to eq true
    end

    it 'should return false if moving one space diagonally forward when not capturing' do
      pawn = FactoryGirl.create(:pawn, x_position: 4, y_position: 4)
      expect(pawn.valid_move?(5, 5)).to eq true
    end
  end
end