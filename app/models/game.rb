class Game < ApplicationRecord
  belongs_to :user_black, class_name: 'User', optional: true
  belongs_to :user_white, class_name: 'User'
  has_many :pieces, dependent: :destroy
  scope :available, -> { where('user_white_id IS NULL OR user_black_id IS NULL') }

  def populate_board!
    # this should create all 32 Pieces with their initial X/Y coordinates.

    # black Pieces
    (1..8).each do |i|
      Piece.create(game_id: id, is_white: false, type: PAWN, x_position: i, y_position: 2)
    end

    Piece.create(game_id: id, is_white: false, type: ROOK, x_position: 1, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: ROOK, x_position: 8, y_position: 1)

    Piece.create(game_id: id, is_white: false, type: KNIGHT, x_position: 2, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: KNIGHT, x_position: 7, y_position: 1)

    Piece.create(game_id: id, is_white: false, type: BISHOP, x_position: 3, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: BISHOP, x_position: 6, y_position: 1)

    Piece.create(game_id: id, is_white: false, type: KING, x_position: 4, y_position: 1)
    Piece.create(game_id: id, is_white: false, type: QUEEN, x_position: 5, y_position: 1)

    # white Pieces
    (1..8).each do |i|
      Piece.create(game_id: id, is_white: true, type: PAWN, x_position: i, y_position: 7)
    end

    Piece.create(game_id: id, is_white: true, type: ROOK, x_position: 1, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: ROOK, x_position: 8, y_position: 8)

    Piece.create(game_id: id, is_white: true, type: KNIGHT, x_position: 2, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: KNIGHT, x_position: 7, y_position: 8)

    Piece.create(game_id: id, is_white: true, type: BISHOP, x_position: 3, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: BISHOP, x_position: 6, y_position: 8)

    Piece.create(game_id: id, is_white: true, type: KING, x_position: 5, y_position: 8)
    Piece.create(game_id: id, is_white: true, type: QUEEN, x_position: 4, y_position: 8)
  end

  def render_piece(x, y)
    piece = Piece.find_by(game_id: id, x_position: x, y_position: y)
    piece.render if piece.present?
  end

  # Determine whether or not the current state of the game is in check (true/false)
  # When the King is being attacked directly by an opponent's piece or
  # when a piece moves to directly attack the opposing king
  def check?
    king = Piece.find_by(game_id: id, type: KING, is_white: is_white)
    Piece.where(game_id: id, is_white: !is_white).each do |piece|
      return true if pieces.valid_move?(king.x_position, king.y_position)
    end
    false
  end
end
