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

  factory :king do
    association :game
  end
end
