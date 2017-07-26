class Game < ApplicationRecord
  belongs_to :user_white, class_name: 'User'
  belongs_to :user_black, class_name: 'User'
  has_many :pieces
end
