require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '#horizonal_or_vertical_obstruction?' do
    it 'tests for unimpeded vertical or horizontal movement' do
      piece_01 = FactoryGirl.build(:piece)
      piece_02 = FactoryGirl.build(:piece, :x_position => 3, :y_position => 1)
      expect.horizonal_or_vertical_obstruction?.to be_false
    end
  end

  describe '#diagonal_obstruction?' do
    it 'tests unimpeded diagonal movement' do
      piece_01 = FactoryGirl.build(:piece)
      piece_02 = FactoryGirl.build(:piece, :x_position => 3, :y_position => 3)
      expect.diagonal_obstruction?.to be_false
    end
  end
end
