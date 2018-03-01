require 'rails_helper'

RSpec.describe King, type: :model do
  describe 'valid_move?' do
    it 'should return true if moving one square up' do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, is_white: false, game: game, x_position: 6, y_position: 3)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 5, y_position: 8)
      expect(king.valid_move?(6, 4)).to eq true
    end

    it 'should return true if moving one square left' do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, is_white: false, game: game, x_position: 6, y_position: 3)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 5, y_position: 8)
      expect(king.valid_move?(5, 3)).to eq true
    end

    it 'should return true if moving one square diagonal' do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, is_white: false, game: game, x_position: 6, y_position: 3)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 5, y_position: 8)
      expect(king.valid_move?(7, 2)).to eq true
    end

    it 'should return false if moving more than one square up' do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, is_white: false, game: game, x_position: 6, y_position: 3)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 5, y_position: 8)
      expect(king.valid_move?(6, 5)).to eq false
    end

    it 'should return false if moving to a random square' do
      game = FactoryGirl.create(:game)
      king = FactoryGirl.create(:king, is_white: false, game: game, x_position: 6, y_position: 3)
      FactoryGirl.create(:king, is_white: true, game: game, x_position: 5, y_position: 8)
      expect(king.valid_move?(3, 7)).to eq false
    end
  end
end
