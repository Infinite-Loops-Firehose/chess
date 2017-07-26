require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#create action' do
    it 'should successfully create new game in the database' do
      user_white = FactoryGirl.create(:user)
      sign_in user_white
      post :create, params: { game: { user_white_id: user_white.id } }
      expect(response).to redirect_to game_path(Game.last)
      expect(Game.last.user_white_id).to eq(user_white.id)
      # expect(Game.last.user_black_id).to eq(user_black.id)
    end
  end

end
