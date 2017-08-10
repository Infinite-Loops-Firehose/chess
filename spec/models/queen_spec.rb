require 'rails_helper'
RSpec.describe 'Queen', type: :model do
  context '#valid_move? for Queen' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @white_queen = @game.pieces.create(is_white: true, type: QUEEN, x_position: 5, y_position: 4)
      @white_pawn = @game.pieces.create(is_white: true, type: PAWN, x_position: 4, y_position: 3)
      @black_rook = @game.pieces.create(is_white: false, type: ROOK, x_position: 6, y_position: 5)
    end

    it 'returns false when Queen move is obstructed' do
      expect(@white_queen.valid_move?(7, 6)).to eq(false)
    end

    it 'returns true when Queen moves vertically' do
      expect(@white_queen.valid_move?(5, 7)).to eq(true)
    end

    it 'returns true when Queen moves horizontally' do
      expect(@white_queen.valid_move?(5, 8)).to eq(true)
    end

    it 'returns true when Queen moves diagonally' do
      expect(@white_queen.valid_move?(2, 7)).to eq(true)
    end
  end
end
