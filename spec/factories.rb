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
  obstructed_game = FactoryGirl.create(:game)
  piece_a1 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 1)
  piece_a2 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 2)
  piece_a6 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 6)
  piece_a8 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 1, y_position: 8)
  piece_b1 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 2, y_position: 1)
  piece_b2 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 2, y_position: 2)
  piece_b6 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 2, y_position: 6)
  piece_c4 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 3, y_position: 4)
  piece_c7 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 3, y_position: 7)
  piece_d1 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 1)
  piece_d4 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 4)
  piece_d7 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 7)
  piece_d8 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 4, y_position: 8)
  piece_e2 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 5, y_position: 2)
  piece_e7 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 5, y_position: 7)
  piece_e8 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 5, y_position: 8)
  piece_f1 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 1)
  piece_f2 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 2)
  piece_f7 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 7)
  piece_f8 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 6, y_position: 8)
  piece_g1 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 1)
  piece_g2 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 2)
  piece_g7 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 7)
  piece_g8 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 7, y_position: 8)
  piece_h1 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 1)
  piece_h2 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 2)
  piece_h6 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 6)
  piece_h7 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 7)
  piece_h8 = FactoryGirl.create(:piece, game_id: obstructed_game.id, x_position: 8, y_position: 8)
  obstructed_game
end
