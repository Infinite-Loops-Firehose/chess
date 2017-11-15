class Game < ApplicationRecord
  belongs_to :user_black, class_name: 'User', optional: true
  belongs_to :user_white, class_name: 'User'
  has_many :pieces, dependent: :destroy
  scope :available, -> { where('user_white_id IS NULL OR user_black_id IS NULL') }

  def populate_board!
    # this should create all 32 Pieces with their initial X/Y coordinates. White pieces will be at bottom of board.

    # White Pieces
    (1..8).each do |i|
      Piece.create(game_id: id, is_white: true, type: PAWN, x_position: i, y_position: 2)
    end

    Piece.create(game_id: id, is_white: true, type: ROOK, x_position: 1, y_position: 1)
    Piece.create(game_id: id, is_white: true, type: ROOK, x_position: 8, y_position: 1)

    Piece.create(game_id: id, is_white: true, type: KNIGHT, x_position: 2, y_position: 1)
    Piece.create(game_id: id, is_white: true, type: KNIGHT, x_position: 7, y_position: 1)

    Piece.create(game_id: id, is_white: true, type: BISHOP, x_position: 3, y_position: 1)
    Piece.create(game_id: id, is_white: true, type: BISHOP, x_position: 6, y_position: 1)

    Piece.create(game_id: id, is_white: true, type: KING, x_position: 4, y_position: 1)
    Piece.create(game_id: id, is_white: true, type: QUEEN, x_position: 5, y_position: 1)

    # Black Pieces
    (1..8).each do |i|
      Piece.create(game_id: id, is_white: false, type: PAWN, x_position: i, y_position: 7)
    end

    Piece.create(game_id: id, is_white: false, type: ROOK, x_position: 1, y_position: 8)
    Piece.create(game_id: id, is_white: false, type: ROOK, x_position: 8, y_position: 8)

    Piece.create(game_id: id, is_white: false, type: KNIGHT, x_position: 2, y_position: 8)
    Piece.create(game_id: id, is_white: false, type: KNIGHT, x_position: 7, y_position: 8)

    Piece.create(game_id: id, is_white: false, type: BISHOP, x_position: 3, y_position: 8)
    Piece.create(game_id: id, is_white: false, type: BISHOP, x_position: 6, y_position: 8)

    Piece.create(game_id: id, is_white: false, type: KING, x_position: 5, y_position: 8)
    Piece.create(game_id: id, is_white: false, type: QUEEN, x_position: 4, y_position: 8)
  end

  def render_piece(x, y)
    piece = get_piece_at_coor(x, y)
    piece.render if piece.present?
  end

  def get_piece_at_coor(x, y)
    pieces.find_by(x_position: x, y_position: y)
  end

  def under_attack?(is_white, x, y)
    pieces.where(is_white: !is_white).where.not(x_position: nil, y_position: nil).find_each do |piece|
      return true if piece.valid_move?(x, y)
    end
    false
  end

  def attacking_piece(is_white) # is_white is the value of the friendly_king, NOT the attacking_piece
    pieces.where(is_white: !is_white).where.not(x_position: nil, y_position: nil).find_each do |piece|
      return piece if piece.valid_move?(friendly_king(is_white).x_position, friendly_king(is_white).y_position)
    end
  end

  def check?(is_white)
    under_attack?(is_white, friendly_king(is_white).x_position, friendly_king(is_white).y_position)
  end

  def checkmate?(is_white) # is_white is the is_white value of the king that may be in checkmate
    return false unless check?(is_white)
    return false if under_attack?(!is_white, attacking_piece(is_white).x_position, attacking_piece(is_white).y_position)
    return false if friendly_king(is_white).can_move_out_of_check?
    return false if attacking_piece(is_white).can_be_blocked?(friendly_king(is_white).x_position, friendly_king(is_white).y_position)
    update_attributes!(player_win: user_black_id, player_lose: user_white_id) if is_white == true
    update_attributes!(player_win: user_white_id, player_lose: user_black_id) if is_white == false
    true
  end

  def enemy_king(is_white)
    pieces.find_by(type: KING, is_white: !is_white)
  end

  def friendly_king(is_white)
    pieces.find_by(type: KING, is_white: is_white)
  end

  def forfeit(current_user)
    if current_user.id == user_white_id
      update_attributes!(player_win: user_black_id, player_lose: user_white_id)
    elsif current_user.id == user_black_id
      update_attributes!(player_win: user_white_id, player_lose: user_black_id)
    end
  end

  def stalemate?(is_white)
    return false if check?(is_white)
    king = pieces.find_by(is_white: is_white, type: KING)
    (1..8).each do |new_x|
      (1..8).each do |new_y|
        pieces.where(is_white: is_white).where.not(x_position: nil, y_position: nil, type: KING).find_each do |piece|
          return false if piece.legal_move?(new_x, new_y)
        end
        return true if king.legal_move?(new_x, new_y) && under_attack?(is_white, new_x, new_y)
      end
    end
    true
  end

  # Use this code to test the stalemate rspec tests:
  # (1..8).each do |new_x|
  #   (1..8).each do |new_y|
  #     pieces.where(is_white: false).where.not(x_position: nil, y_position: nil, type: KING).find_each do |piece|
  #       puts "#{[new_x, new_y]}: legal move for #{piece.type} at [#{piece.x_position}, #{piece.y_position}]? #{piece.legal_move?(new_x, new_y)}"
  #     end
  #   end
  # end

  IN_PLAY = 0
  FORFEIT = 1
  CHECKMATE = 2
  STALEMATE = 3
  AGREED_DRAW = 4
end
