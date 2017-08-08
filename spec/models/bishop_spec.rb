require 'rails_helper'

RSpec.describe 'Bishop', type: :model do
  context '#valid_move? for Bishop' do
    game = FactoryGirl.create(:game)
    white_bishop = game.pieces.create(is_white: true, type: BISHOP, x_position: 5, y_position: 4)
    white_pawn = game.pieces.create(is_white: true, type: PAWN, x_position: 4, y_position: 3)
    black_rook = game.pieces.create(is_white: false, type: ROOK, x_position: 6, y_position: 5)
    context 'when move is obstructed' do
      it "returns false when bishop move is obstructed" do
        expect(white_bishop.valid_move?(7, 6)).to eq(false)
      end
    end
  end
end