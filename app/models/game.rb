class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces

  scope :available, -> { where('user_white_id IS NULL OR user_black_id IS NULL') }
end
