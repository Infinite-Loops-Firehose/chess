require 'rails_helper'


RSpec.describe Game, type: :model do
  describe "#populate_board!" do

    it 'creates 32 pieces on the board' do
      game = FactoryGirl.create(:game)
      game.populate_board!
      expect(game.pieces.count).to eq(32)
    end

    it "creates correct number of pawns" do
      user_white = FactoryGirl.create(:user)
      game = Game.create(user_white_id: user_white.id)
      game.populate_board!
     # n_white_pawns = Pawn.where(game: game, is_white: true).count
      n_white_pawns = game.pieces.where(type: 'Pawn', is_white: true).count
      expect(n_white_pawns).to eq(8)
    end

    it "Puts pawns in the correct starting positions" 

  end

end
