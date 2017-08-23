require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe 'games#create action' do
    it 'should successfully create new game in the database' do
      user_white = FactoryGirl.create(:user)
      sign_in user_white
      post :create, params: { game: { user_white_id: user_white.id } }
      expect(response).to redirect_to game_path(Game.last)
      expect(Game.last.user_white_id).to eq(user_white.id)
    end
  end

  describe 'games#forfeit action' do
    let(:game) { FactoryGirl.create :game }
    let(:user_white) { FactoryGirl.create :user }
    let(:user_black) { FactoryGirl.create :user }

    it 'should redirect to the home page' do
      expect(response).to be_successful
    end
  end
end
