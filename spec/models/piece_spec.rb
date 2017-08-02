require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '#obstructed?' do
    let(:game) { create :obstructed_game }

    context 'not obstructed' do
      it 'checks for vertical obstruction between A8 and A6' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 8)
        expect(piece.obstructed?(1, 6)).to eq(false)
      end

      it 'checks for horizontal obstruction between A8 and C8' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 8)
        expect(piece.obstructed?(3, 8)).to eq(false)
      end

      it 'diagonal between A6 and C4' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 6)
        expect(piece.obstructed?(3, 4)).to eq(false)
      end
    end

    context 'obstructed' do
      it 'checks for vertical obstruction between A1 and A4' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 1)
        piece2 = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 2)
        expect(piece.obstructed?(1, 4)).to eq(true)
      end

      it 'diagonal between F1 and D3' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 6, y_position: 1)
        expect(piece.obstructed?(4, 3)).to eq(true)
      end

      it 'checks for horizontal obstruction between A8 and C8' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, x_position: 1, y_position: 8)
        piece2 = FactoryGirl.create(:piece, game_id: game.id, x_position: 3, y_position: 8)
        expect(piece.obstructed?(5, 8)).to eq(true)
      end
    end

    context 'invalid' do
      it 'invalid move between D4 and B5' do
        game = obstructed_game
        piece = FactoryGirl.create(:piece, game_id: game.id, :x_position => 4, :y_position => 4)
        expect(piece.obstructed?(2, 9)).to eq(true)
      end
    end
  end
end

# cases to test for:
# is_obstructed? A6 -> C4 => false
# is_obstructed? F1 -> D3 => true
# is_obstructed? A1 -> A4 => true
# is_obstructed? D4 -> B5 => Raise an Error Message # invalid input.  Not diagnal, horizontal, or vertical.
# is_obstructed? A8 -> A6 => false # note: this is not an obstruction.  This has a piece in the destination, but not in between the pieces.
# is_obstructed? A8 -> C8 => false
