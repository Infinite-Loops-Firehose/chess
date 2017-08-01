class Game < ApplicationRecord
  belongs_to :user_black, class_name: 'User', optional: true
  belongs_to :user_white, class_name: 'User'
  has_many :pieces
  scope :available, -> { where('user_white_id IS NULL OR user_black_id IS NULL') }

  def populate_board!
    # this should create all 32 Pieces with their initial X/Y coordinates.

    # black Pieces
    (1..8).each do |i|
      Piece.create(game_id: id, is_white: false, type: Piece::PAWN, x_position: i, y_position: 2)
    end

    Piece.create(game_id: id, is_white: false, type: Piece::ROOK, x_position: 1, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: Piece::ROOK, x_position: 8, y_position: 1)

    Piece.create(game_id: id, is_white: false, type: Piece::KNIGHT, x_position: 2, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: Piece::KNIGHT, x_position: 7, y_position: 1)

    Piece.create(game_id: id, is_white: false, type: Piece::BISHOP, x_position: 3, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: Piece::BISHOP, x_position: 6, y_position: 1)

    Piece.create(game_id: id, is_white: false, type: Piece::KING, x_position: 4, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: Piece::QUEEN, x_position: 5, y_position: 1)

    # white Pieces
    (1..8).each do |i|
      Piece.create(game_id: id, is_white: true, type: Piece::PAWN, x_position: i, y_position: 7)
    end

    Piece.create(game_id: id, is_white: true, type: Piece::ROOK, x_position: 1, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: Piece::ROOK, x_position: 8, y_position: 8)

    Piece.create(game_id: id, is_white: true, type: Piece::KNIGHT, x_position: 2, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: Piece::KNIGHT, x_position: 7, y_position: 8)

    Piece.create(game_id: id, is_white: true, type: Piece::BISHOP, x_position: 3, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: Piece::BISHOP, x_position: 6, y_position: 8)

    Piece.create(game_id: id, is_white: true, type: Piece::KING, x_position: 5, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: Piece::QUEEN, x_position: 4, y_position: 8)
  end
end
