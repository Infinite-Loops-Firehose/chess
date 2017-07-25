require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#create action" do
    it "should successfully create new game in the database" do
      post :create, params: { game: {game_id: 1, user_white_id: 1, user_black_id: 2} }
      expect(response).to redirect_to game_path
    end
  end
end
