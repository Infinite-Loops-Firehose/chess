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
    unless valid_move?(new_x, new_y)
      raise ArgumentError, "That is an invalid move for #{type}"
    end
    unless square_occupied?(new_x, new_y)
      update_attributes(x_position: new_x, y_position: new_y)
      increment_move
      return
    end
    occupying_piece = Piece.get_piece_at_coor(new_x, new_y)
    unless id != occupying_piece.id
      raise ArgumentError, 'That is an invalid move. Piece is still in starting square.'
    end
    unless (occupying_piece.is_white && is_white?) || (!occupying_piece.is_white && !is_white?)
      capture_piece(occupying_piece)
      update_attributes(x_position: new_x, y_position: new_y)
      increment_move
      return occupying_piece
    end
    raise ArgumentError, 'That is an invalid move. Cannot capture your own piece.'
  end

  def square_occupied?(new_x, new_y)
    piece = game.pieces.find_by(x_position: new_x, y_position: new_y)
    return false if piece.nil?
    true
  end

  def self.get_piece_at_coor(x, y)
    Piece.find_by(x_position: x, y_position: y)
  end

  def capture_piece(piece_captured)
    piece_captured.update_attributes(x_position: nil, y_position: nil)
  end

  def obstructed?(new_x, new_y)
    # errors.add(:base, 'Pieces cannot be moved off the board: invalid move')
    return true if invalid?(new_x.to_i, new_y.to_i)
    # errors.add(:base, 'There is a horizontal or vertical obstruction: invalid move')
    return true if horizontal_or_vertical_obstruction?(new_x, new_y)
    # errors.add(:base, 'There is a diagonal obstruction: invalid move')
    return true if diagonal_obstruction?(new_x, new_y)
    false
  end

  private

  def increment_move
    game.update_attributes(move_number: game.move_number + 1)
    update_attributes(game_move_number: game.move_number, piece_move_number: piece_move_number + 1, has_moved: true)
  end

  def invalid?(new_x, new_y)
    new_x < 1 || new_x > 8 || new_y < 1 || new_y > 8
  end

  def horizontal_or_vertical?(new_x, new_y)
    new_x == x_position || new_y == y_position
  end

  def diagonal?(new_x, new_y)
    # in order for the move to be diagonal, the piece must be moving by the same distance both horizontally and vertically.
    return true if (new_x.to_i - x_position).abs == (new_y.to_i - y_position).abs
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
      obstructing_piece = Piece.get_piece_at_coor(coor.first, coor.last)
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
