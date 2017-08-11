FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@gmail.com" }
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

  factory :king do
    association :game
  end

  factory :rook do
    association :game
  end
end
