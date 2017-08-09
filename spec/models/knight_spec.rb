require 'rails_helper'

RSpec.describe Knight, type: :model do
  describe 'valid_move?' do
    let(:knight) { FactoryGirl.create :knight, x_position: 3, y_position: 5 }

    context 'valid move' do
      it 'up and right' do
        expect(knight.valid_move?(4,7)).to eq(true)
      end

      it 'up and left' do
        expect(knight.valid_move?(2,7)).to eq(true)
      end
    end
  end
end