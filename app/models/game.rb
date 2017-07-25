class Game < ApplicationRecord
  belongs_to :user
  has_many :pieces

  def populate_board!
    # this should create all 32 pieces with their initial X/Y coordinates.

    # black pieces
    (1..8).each do |i|
      Pawn.create(x_position: i, y_position: 2, game_id: id, is_white: false)
    end

    Rook.create(x_position: 1, y_position: 1, game_id: id, is_white: false)
    Rook.create(x_position: 8, y_position: 1, game_id: id, is_white: false)

    Knight.create(x_position: 2, y_position: 1, game_id: id, is_white: false)
    Knight.create(x_position: 7, y_position: 1, game_id: id, is_white: false)

    Bishop.create(x_position: 3, y_position: 1, game_id: id, is_white: false)
    Bishop.create(x_position: 6, y_position: 1, game_id: id, is_white: false)

    King.create(x_position: 4, y_position: 1, game_id: id, is_white: false)
    Queen.create(x_position: 5, y_position: 1, game_id: id, is_white: false)

    # white pieces
    (1..8).each do |i|
      Pawn.create(x_position: i, y_position: 7, game_id: id, is_white: true)
    end

    Rook.create(x_position: 1, y_position: 8, game_id: id, is_white: true)
    Rook.create(x_position: 8, y_position: 8, game_id: id, is_white: true)

    Knight.create(x_position: 2, y_position: 8, game_id: id, is_white: true)
    Knight.create(x_position: 7, y_position: 8, game_id: id, is_white: true)

    Bishop.create(x_position: 3, y_position: 8, game_id: id, is_white: true)
    Bishop.create(x_position: 6, y_position: 8, game_id: id, is_white: true)

    King.create(x_position: 4, y_position: 8, game_id: id, is_white: true)
    Queen.create(x_position: 5, y_position: 8, game_id: id, is_white: true)
  end
end

