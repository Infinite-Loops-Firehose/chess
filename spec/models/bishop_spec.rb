require 'rails_helper'
RSpec.describe 'Bishop', type: :model do
  context '#valid_move? for Bishop' do
    before(:each) do
      @game = FactoryGirl.create(:game)
      @white_bishop = @game.pieces.create(is_white: true, type: BISHOP, x_position: 5, y_position: 4)
      @white_pawn = @game.pieces.create(is_white: true, type: PAWN, x_position: 4, y_position: 3)
      @black_rook = @game.pieces.create(is_white: false, type: ROOK, x_position: 6, y_position: 5)
    end
    
    it 'returns false when bishop move is obstructed' do
      expect(@white_bishop.valid_move?(7, 6)).to eq(false)
    end

    it 'returns false when bishop moves vertically' do
      expect(@white_bishop.valid_move?(5, 7)).to eq(false)
    end

    it 'returns false when bishop move horizontally' do
      expect(@white_bishop.valid_move?(7, 8)).to eq(false)
    end

    it 'returns true when bishop move diagonally' do
      expect(@white_bishop.valid_move?(2, 7)).to eq(true)
    end
  end
end
