FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "fakeemail#{n}@gmail.com"
    end
    password 'secretPassword'
    password_confirmation 'secretPassword'
    name 'username'
    games_played 0
    games_won 0
  end

  factory :game do
    association :user_white, factory: :user
  end

  factory :piece do
    x_position 1
    y_position 1
  end
end

# I want this method to populate a board with the obstructed pieces that are in Ken's example
def obstructed_game
  obstructed_game = FactoryGirl.create(:game, id: 1)
  piece_A1 = FactoryGirl.create(:piece, game_id: 1, x_position: 1, y_position: 1)
  piece_A2 = FactoryGirl.create(:piece, game_id: 1, x_position: 1, y_position: 2)
  piece_A6 = FactoryGirl.create(:piece, game_id: 1, x_position: 1, y_position: 6)
  piece_A8 = FactoryGirl.create(:piece, game_id: 1, x_position: 1, y_position: 8)
  piece_B1 = FactoryGirl.create(:piece, game_id: 1, x_position: 2, y_position: 1)
  piece_B2 = FactoryGirl.create(:piece, game_id: 1, x_position: 2, y_position: 2)
  piece_B6 = FactoryGirl.create(:piece, game_id: 1, x_position: 2, y_position: 6)
  piece_C4 = FactoryGirl.create(:piece, game_id: 1, x_position: 3, y_position: 4)
  piece_C7 = FactoryGirl.create(:piece, game_id: 1, x_position: 3, y_position: 7)
  piece_D1 = FactoryGirl.create(:piece, game_id: 1, x_position: 4, y_position: 1)
  piece_D4 = FactoryGirl.create(:piece, game_id: 1, x_position: 4, y_position: 4)
  piece_D7 = FactoryGirl.create(:piece, game_id: 1, x_position: 4, y_position: 7)
  piece_D8 = FactoryGirl.create(:piece, game_id: 1, x_position: 4, y_position: 8)
  piece_E2 = FactoryGirl.create(:piece, game_id: 1, x_position: 5, y_position: 2)
  piece_E7 = FactoryGirl.create(:piece, game_id: 1, x_position: 5, y_position: 7)
  piece_E8 = FactoryGirl.create(:piece, game_id: 1, x_position: 5, y_position: 8)
  piece_F1 = FactoryGirl.create(:piece, game_id: 1, x_position: 6, y_position: 1)
  piece_F2 = FactoryGirl.create(:piece, game_id: 1, x_position: 6, y_position: 2)
  piece_F7 = FactoryGirl.create(:piece, game_id: 1, x_position: 6, y_position: 7)
  piece_F8 = FactoryGirl.create(:piece, game_id: 1, x_position: 6, y_position: 8)
  piece_G1 = FactoryGirl.create(:piece, game_id: 1, x_position: 7, y_position: 1)
  piece_G2 = FactoryGirl.create(:piece, game_id: 1, x_position: 7, y_position: 2)
  piece_G7 = FactoryGirl.create(:piece, game_id: 1, x_position: 7, y_position: 7)
  piece_G8 = FactoryGirl.create(:piece, game_id: 1, x_position: 7, y_position: 8)
  piece_H1 = FactoryGirl.create(:piece, game_id: 1, x_position: 8, y_position: 1)
  piece_H2 = FactoryGirl.create(:piece, game_id: 1, x_position: 8, y_position: 2)
  piece_H6 = FactoryGirl.create(:piece, game_id: 1, x_position: 8, y_position: 6)
  piece_H7 = FactoryGirl.create(:piece, game_id: 1, x_position: 8, y_position: 7)
  piece_H8 = FactoryGirl.create(:piece, game_id: 1, x_position: 8, y_position: 8)
end

