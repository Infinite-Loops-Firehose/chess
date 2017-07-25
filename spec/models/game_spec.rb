require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'should have correct number of pieces' do
    game = Game.create(user_white_id: 0, user_black_id: 1)
    game.populate_board!
    expect(game.pieces.count).to eq(32)
  end
end
