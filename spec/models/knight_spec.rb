require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'valid_move?' do
    let(:knight) { FactoryGirl.create :knight, x_position: 3, y_position: 5 }
    let(:edge_knight) { FactoryGirl.create :knight, x_position: 1, y_position: 2 }

    context 'valid move' do
      it 'up and right' do
        expect(knight.valid_move?(4, 7)).to eq(true)
      end

      it 'up and left' do
        expect(knight.valid_move?(2, 7)).to eq(true)
      end

      it 'down and right' do
        expect(knight.valid_move?(4, 3)).to eq(true)
      end

      it 'down and left' do
        expect(knight.valid_move?(2, 3)).to eq(true)
      end

      it 'right and up' do
        expect(knight.valid_move?(5, 6)).to eq(true)
      end

      it 'right and down' do
        expect(knight.valid_move?(5, 4)).to eq(true)
      end

      it 'left and up' do
        expect(knight.valid_move?(1, 6)).to eq(true)
      end

      it 'left and down' do
        expect(knight.valid_move?(1, 4)).to eq(true)
      end
    end

    context 'invalid move' do
      it 'does not move' do
        expect(knight.valid_move?(3, 5)).to eq(false)
      end

      it 'moves diagonal' do
        expect(knight.valid_move?(2, 6)).to eq(false)
      end

      it 'moves horizontal' do
        expect(knight.valid_move?(3, 8)).to eq(false)
      end
    end

    context 'edge move' do
      it 'valid move' do
        expect(edge_knight.valid_move?(3, 1)).to eq(true)
      end

      it 'invalid move' do
        expect(edge_knight.valid_move?(1, 4)).to eq(false)
      end
    end
  end
end
