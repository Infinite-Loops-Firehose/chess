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

  def check?(is_white)
    king = pieces.find_by(type: KING, is_white: is_white)
    return false if king.nil? # used for tests where there is no king generated
    pieces.where(game_id: id, is_white: !is_white).where.not(x_position: nil, y_position: nil).find_each do |piece|
      next if piece.x_position.nil? || piece.y_position.nil?
      return true if piece.valid_move?(king.x_position, king.y_position)
    end
    false
  end

  def stalemate?(is_white)
    return false if check?(is_white)
    (1..8).each do |new_x|
      (1..8).each do |new_y|
        pieces.where(is_white: is_white).where.not(x_position: nil, y_position: nil).find_each do |piece|
          return false if legal_move?(piece, new_x, new_y)
        end
      end
    end
    true
  end

  def legal_move?(piece, new_x, new_y)
    return false unless piece.actual_move?(new_x, new_y)
    return_val = false
    piece_moved_start_x = piece.x_position
    piece_moved_start_y = piece.y_position
    piece_captured = nil
    piece_captured_x = nil
    piece_captured_y = nil
    # check if you are moving pawn in en passant capture of enemy pawn
    if piece.type == PAWN && !piece.square_occupied?(new_x, new_y)
      if (new_x - piece_moved_start_x).abs == 1 && (new_y - piece_moved_start_y).abs == 1
        piece_captured = Piece.get_piece_at_coor(new_x, piece_moved_start_y)
        piece_captured_x = new_x
        piece_captured_y = piece_moved_start_y
      end
    end
    # return false if move is invalid for this piece for any of the reasons checked in piece #valid_move?
    return false unless piece.valid_move?(new_x, new_y)
    # If square is occupied, respond according to whether piece is occupied by friend or foe
    if piece.square_occupied?(new_x, new_y)
      occupying_piece = Piece.get_piece_at_coor(new_x, new_y)
      return false if (occupying_piece.is_white && piece.is_white?) || (!occupying_piece.is_white && !piece.is_white?)
      # since player is trying to capture a friendly piece
      piece_captured = occupying_piece
      piece_captured_x = occupying_piece.x_position
      piece_captured_y = occupying_piece.y_position
      piece.capture_piece(occupying_piece)
    end
    # only here do we update coordinates of piece moved, once we have saved all starting coordinates of piece moved and any piece it captured
    piece.update_attributes(x_position: new_x, y_position: new_y)
    piece.increment_move
    return_val = false if check?(piece.is_white) # since the preceding move will leave the player's king in check
    return_val = true unless check?(piece.is_white)
    piece.update_attributes(x_position: piece_moved_start_x, y_position: piece_moved_start_y)
    piece_captured.update_attributes(x_position: piece_captured_x, y_position: piece_captured_y) unless piece_captured.nil?
    piece.decrement_move
    return_val
  end
end

IN_PLAY = 0
FORFEIT = 1
CHECKMATE = 2
STALEMATE = 3
AGREED_DRAW = 4
