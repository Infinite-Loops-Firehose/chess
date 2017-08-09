require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe '#valid_move?' do
    let(:game) { FactoryGirl.create :game }
    let(:rook) { FactoryGirl.create :rook, game_id: game.id, x_position: 3, y_position: 3 }

    context 'valid move' do
      it 'vertical move up' do
        expect(rook.valid_move?(3, 8)).to eq(true)
      end

      it 'vetical move down' do
        expect(rook.valid_move?(3, 1)).to eq(true)
      end

      it 'horizontal right' do
        expect(rook.valid_move?(8, 3)).to eq(true)
      end

      it 'horizontal left' do
        expect(rook.valid_move?(1, 3)).to eq(true)
      end
    end

    context 'invalid move' do
      it 'does not move' do
        expect(rook.valid_move?(3, 3)).to eq(false)
      end

      it 'moves diagonal' do
        expect(rook.valid_move?(5, 5)).to eq(false)
      end

      it 'obstruction' do
        FactoryGirl.create(:piece, game_id: game.id, type: PAWN, x_position: 3, y_position: 5)
        expect(rook.valid_move?(3, 8)).to eq(false)
      end
    end
  end
end

