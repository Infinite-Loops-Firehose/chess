require 'rails_helper'

RSpec.describe Rook, type: :model do
  describe '#valid_move?' do
    it 'checks for valie move to the right' do
      rook = FactoryGirl.create(:rook, x_position: 1, y_position: 1)
      expect(rook.valid_move?(5,1)).to eq(true)
    end
  end
end