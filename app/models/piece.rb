class Piece < ApplicationRecord
  # class OffBoardError < StandardError; end   <-- we may want to use this at some point for error messages

  belongs_to :game

  def color
    return 'White' if is_white == true
    'Black'
  end

  def render
    "#{color} #{type}"
  end

  def move_to!(new_x, new_y)
    transaction do
      unless actual_move?(new_x, new_y)
        raise ArgumentError, 'That is an invalid move. Piece is still in starting square.'
      end
      unless valid_move?(new_x, new_y)
        raise ArgumentError, "That is an invalid move for #{type}"
      end
      if square_occupied?(new_x, new_y)
        occupying_piece = game.get_piece_at_coor(new_x, new_y)
        raise ArgumentError, 'That is an invalid move. Cannot capture your own piece.' if (occupying_piece.is_white && is_white?) || (!occupying_piece.is_white && !is_white?)
        capture_piece(occupying_piece)
      end
      update_attributes(x_position: new_x, y_position: new_y)
      increment_move
      raise ArgumentError, 'That is an invalid move that leaves your king in check.' if game.check?(is_white)
      if game.stalemate?(!is_white)
        game.state == STALEMATE
      end
      if game.state != IN_PLAY
        # prevent all moves, print game over message
      end
    end
  end

  def actual_move?(new_x, new_y)
    piece_found = game.get_piece_at_coor(new_x, new_y)
    return true if piece_found.nil?
    return false if piece_found.id == id
    true
  end

  def square_occupied?(new_x, new_y)
    piece = game.pieces.find_by(x_position: new_x, y_position: new_y)
    return false if piece.nil?
    true
  end

  def capture_piece(piece_captured)
    piece_captured.update_attributes(x_position: nil, y_position: nil)
  end

  def obstructed?(new_x, new_y)
    # errors.add(:base, 'Pieces cannot be moved off the board: invalid move')
    return true if invalid?(new_x, new_y)
    # errors.add(:base, 'There is a horizontal or vertical obstruction: invalid move')
    return true if horizontal_or_vertical_obstruction?(new_x, new_y)
    # errors.add(:base, 'There is a diagonal obstruction: invalid move')
    return true if diagonal_obstruction?(new_x, new_y)
    false
  end

  def increment_move
    game.update_attributes(move_number: game.move_number + 1)
    update_attributes(game_move_number: game.move_number, piece_move_number: piece_move_number + 1)
    update_attributes(has_moved: true)
  end

  def decrement_move
    game.update_attributes(move_number: game.move_number - 1)
    update_attributes(game_move_number: game.move_number, piece_move_number: piece_move_number - 1)
    update_attributes(has_moved: false) if piece_move_number.zero?
  end

  def legal_move?(new_x, new_y) # used only when checking for stalemate in a particular game, not when making permanent moves in game
    return false unless actual_move?(new_x, new_y)
    return_val = false
    piece_moved_start_x = x_position
    piece_moved_start_y = y_position
    piece_captured = nil
    piece_captured_x = nil
    piece_captured_y = nil
    # check if you are moving pawn in en passant capture of enemy pawn
    if type == PAWN && !square_occupied?(new_x, new_y)
      if (new_x - piece_moved_start_x).abs == 1 && (new_y - piece_moved_start_y).abs == 1
        piece_captured = game.get_piece_at_coor(new_x, piece_moved_start_y)
        piece_captured_x = new_x
        piece_captured_y = piece_moved_start_y
      end
    end
    # return false if move is invalid for this piece for any of the reasons checked in piece #valid_move?
    return false unless valid_move?(new_x, new_y)
    # If square is occupied, respond according to whether piece is occupied by friend or foe
    if square_occupied?(new_x, new_y)
      occupying_piece = game.get_piece_at_coor(new_x, new_y)
      return false if (occupying_piece.is_white && is_white?) || (!occupying_piece.is_white && !is_white?)
      # since player is trying to capture a friendly piece
      piece_captured = occupying_piece
      piece_captured_x = occupying_piece.x_position
      piece_captured_y = occupying_piece.y_position
      capture_piece(occupying_piece)
    end
    # only here do we update coordinates of piece moved, once we have saved all starting coordinates of piece moved and any piece it captured
    update_attributes(x_position: new_x, y_position: new_y)
    increment_move
    return_val = false if game.check?(is_white) # since the preceding move will leave the player's king in check
    return_val = true unless game.check?(is_white)
    update_attributes(x_position: piece_moved_start_x, y_position: piece_moved_start_y)
    piece_captured.update_attributes(x_position: piece_captured_x, y_position: piece_captured_y) unless piece_captured.nil?
    decrement_move
    return_val
  end

  private

  def invalid?(new_x, new_y)
    new_x < 1 || new_x > 8 || new_y < 1 || new_y > 8
  end

  def horizontal_or_vertical?(new_x, new_y)
    new_x == x_position || new_y == y_position
  end

  def diagonal?(new_x, new_y)
    # in order for the move to be diagonal, the piece must be moving by the same distance both horizontally and vertically.
    return true if (new_x - x_position).abs == (new_y - y_position).abs
  end

  def vertical_obstruction?(range_y)
    obstruction = game.pieces.where(y_position: ((range_y.first + 1)..(range_y.last - 1)), x_position: x_position) # will always return something, even if it's an empty query
    obstruction.present?
  end

  def horizontal_obstruction?(range_x)
    obstruction = game.pieces.where(y_position: y_position, x_position: (range_x.first + 1)..(range_x.last - 1)) # will always return something, even if it's an empty query
    obstruction.present?
  end

  def horizontal_or_vertical_obstruction?(new_x, new_y)
    return false unless horizontal_or_vertical?(new_x, new_y)
    range_x = [new_x, x_position].sort
    range_y = [new_y, y_position].sort
    vertical_obstruction?(range_y) || horizontal_obstruction?(range_x)
  end

  def diagonal_obstruction?(new_x, new_y)
    return false unless diagonal?(new_x, new_y)
    x_values = if x_position.to_i < new_x.to_i
                 (x_position.to_i..new_x.to_i).to_a # array of x values, including the starting and ending squares
               else
                 x_position.to_i.downto(new_x.to_i).to_a
               end

    y_values = if y_position.to_i < new_y.to_i
                 (y_position.to_i..new_y.to_i).to_a # array of y values, including the starting and ending squares
               else
                 y_position.to_i.downto(new_y.to_i).to_a
               end

    coordinates = []

    x_values.zip(y_values) do |x_value, y_value| # combines x_value and y_value pairs into a multidimensional array
      coordinates << [x_value, y_value] # [ [1, 1], [2, 2], [3, 3] ] for example
    end

    coordinates.shift
    coordinates.pop # this is an array of only the in-between squares - not including the start or end squares
    coordinates.each do |coor|
      obstructing_piece = game.get_piece_at_coor(coor.first, coor.last)
      return true if obstructing_piece.present?
    end
    false
  end
end

PAWN = 'Pawn'.freeze
ROOK = 'Rook'.freeze
KNIGHT = 'Knight'.freeze
BISHOP = 'Bishop'.freeze
QUEEN = 'Queen'.freeze
KING = 'King'.freeze
