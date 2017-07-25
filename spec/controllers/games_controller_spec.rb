require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#create action" do
    it "should successfully create new game in the database" do
      user = FactoryGirl.create(:user)
      post :create, params: { game: {user_white_id: 1, user_black_id: 2} }
      expect(response).to redirect_to game_path(Game.last)
      expect(Game.last.user_white_id).to eq(1)
      expect(Game.last.user_black_id).to eq(2)
    end
  end
end
