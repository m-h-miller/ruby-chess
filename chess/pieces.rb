require 'byebug'

class Piece

  attr_reader :color, :position

  def initialize(position, board, color)
    @color = color
    @position = position
    @board = board
  end

  def empty?
    false
  end

end

class Pawn < Piece

  def to_s
    " P ".colorize(color)
  end
end

module PerpSlidingPiece
  PERP_MOVES = [ [0,1], [1,0], [0, -1], [-1, 0] ]

  def generate_moves
    moves = []
    # debugger
    PERP_MOVES.each do |diff_x, diff_y|
      current_pos = self.position

      while Board.within_board?(current_pos)
        new_pos = [current_pos[0] + diff_x, current_pos[1] + diff_y]
        break unless Board.within_board?(new_pos)
        break unless @board[new_pos].empty?
        moves << new_pos
        current_pos = new_pos

      end
    end
    moves
  end

end


module DiagSlidingPiece
  DIAG_MOVES = [ [1,1], [-1,1], [1,-1], [-1,-1] ]
  valid_moves = []
end

class SteppingPiece < Piece
end

class Rook < Piece
  include PerpSlidingPiece

  def to_s
    " R ".colorize(color)
  end

end

class Bishop < Piece
  def to_s
    " B ".colorize(color)
  end
end

class Queen < Piece
  def to_s
    " Q ".colorize(color)
  end
end

class King < Piece
  def to_s
    " K ".colorize(color)
  end
end

class Knight < Piece
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
