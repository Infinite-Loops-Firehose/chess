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

  # describe 'game#forfeit action' do
  #   let(:user_white) { FactoryGirl.create :user }
  #   let(:user_black) { FactoryGirl.create :user }
  #   it 'should forfeit the game' do
  #     sign_in user_white
  #     sign_in user_black
  #     post :forfeit, params: { game: { player_win: user_white.id } }
  #     expect(response).to redirect_to game_path(@game)
  #   end

  #   it 'should redirect to the home page' do
  #   end

  #   it 'should assign a winner' do
  #   end
  # end
end



# 1. create forfeit method
# 2. Forfeit method will
#   a. End game
#   b. Assign other player as winner
# 3. Create button
# 4. Link button to gameforfeit method
# 4. link to index page