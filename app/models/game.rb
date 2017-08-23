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
    pieces.where(game_id: id, is_white: !is_white).find_each do |piece|
      return true if piece.valid_move?(king.x_position, king.y_position)
    end
    false
  end

  # def stalemate?(is_white) # is_white is true if white king is stalemated
  #   king = pieces.find_by(type: KING, is_white: is_white)
  #   return false if check?(king.is_white)
  #   pieces.where(game_id: id, is_white: is_white).each do |piece|
  #     check_moves_stalemate?(piece, king)
  #   end
  #   false  
  # end

  # def check_moves_stalemate?(piece, king)
  #   (1..8).each do |x|
  #     (1..8).each do |y|
  #       if piece.valid_move?(x, y)
  #         # store original piece coordinates in startX and startY
  #         moved_start_x = piece.x_position
  #         moved_start_y = piece.y_position
  #         dest_sq_piece = Piece.get_piece_at_coor(x_position: x, y_position: y)
  #         if 
  #         unless piece_captured.nil?
  #             piece_captured_starting_x = x
  #             piece_captured_starting_y = y
  #         end
  #         begin 
  #         piece.move_to!(x, y)
  #       end    
  #         rescue ArgumentError
  #           next
  #         end
  #         if check?(king.is_white)
  #           piece.update_attributes(x_position: moved_start_x, y_position: moved_start_y)
  #           unless piece_captured.nil?
  #             piece_captured.move_to!()
  #           end
  #           next
  #         else
  #           return false 
  #         end
  #       end
  #     end
  #   end
  #   true
  # end

  # def test_move_error?(piece, x, y)
    
  # end
end
