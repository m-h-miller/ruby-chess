require 'byebug'
require_relative 'sliding_piece.rb'
require_relative 'stepping_piece.rb'

class Piece

  attr_reader :color, :position

  def initialize(position, board, color)
    @color = color
    @position = position
    @board = board
  end

  def valid_moves
    self.generate_moves.reject { |pos| move_into_check?(pos)}
  end

  def move_into_check?(pos)
    dup = @board.deep_dup
    old_pos = self.position
    dup[pos] = self.class.new(pos, dup, self.color)
    dup[old_pos] = NullPiece.new(old_pos, dup, :green)
    dup.in_check?(self.color)
  end

  def empty?
    false
  end

end

class Pawn < Piece
  # MOVES_BLACK = [ [0,-1], [0,-2] ]
  # MOVES_RED = [ [0,1], [0,2] ]
  CAPTURE_BLACK = [[1,-1], [-1,-1] ]
  CAPTURE_RED = [ [1,1], [-1,1] ]

  def to_s
    " P ".colorize(color)
  end

  def at_start?
    if self.color == :black
      return true if self.position[1] == 6
    elsif self.color == :red
      return true if self.position[1] == 1
    end
    false
  end

  def capturable_pos #return positions
    x, y = self.position
    moves = []
    if self.color == :black
      CAPTURE_BLACK.each do |x_diff, y_diff|
        new_pos = [x + x_diff, y + y_diff]
        next if !Board.within_board?(new_pos)
        moves << new_pos if @board[new_pos].color == :red
      end
    elsif self.color == :red
      CAPTURE_RED.each do |x_diff, y_diff|
        new_pos = [x + x_diff, y + y_diff]
        next if !Board.within_board?(new_pos)
        moves << new_pos if @board[new_pos].color == :black
      end
    end
    moves
  end


  def generate_moves
    moves = []
    x, y = self.position
    if self.color == :black
      new_pos = [x, y-1]
      moves << new_pos if @board[new_pos].empty? && Board.within_board?(new_pos)

      moves << [x, y-2] if at_start?

      moves << capturable_pos unless capturable_pos.empty?
    elsif self.color == :red
      new_pos = [x, y+1]
      moves << new_pos if @board[new_pos].empty? && Board.within_board?(new_pos)

      moves << [x, y+2] if at_start?

      moves << capturable_pos unless capturable_pos.empty?
    end
    moves
  end
end


class Rook < Piece
  include SlidingPiece
  MOVES = [ [0,1], [1,0], [0, -1], [-1, 0] ]
  def to_s
    " R ".colorize(color)
  end

end

class Bishop < Piece
  include SlidingPiece
  MOVES = [ [1,1], [-1,1], [1,-1], [-1,-1] ]
  def to_s
    " B ".colorize(color)
  end
end

class Queen < Piece
  include SlidingPiece
  MOVES = [ [1,1], [-1,1], [1,-1], [-1,-1] ] + [ [0,1], [1,0], [0, -1], [-1, 0] ]
  def to_s
    " Q ".colorize(color)
  end
end

class King < Piece
  include SteppingPiece
  MOVES = [ [1,1], [-1,1], [1,-1], [-1,-1], [0,1], [1,0], [0, -1], [-1, 0] ]
  def to_s
    " K ".colorize(color)
  end
end

class Knight < Piece
  include SteppingPiece
  MOVES = [ [1, 2], [1, -2], [-1, 2], [-1, -2], [2, 1], [2, -1], [-2, 1], [-2, -1] ]
  def to_s
    " N ".colorize(color)
  end
end

class NullPiece < Piece
  def to_s
    "   "
  end

  def empty?
    true
  end
end
