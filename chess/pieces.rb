require 'byebug'

class Piece

  attr_reader :color, :position

  def initialize(position, board, color)
    @color = color
    @position = position
    @board = board
  end


  def within_board?
    return false if self.position.all? { |x| x.between?(0, 7) }
    true
  end

end

class Pawn < Piece

  def to_s
    " P ".colorize(color)
  end
end

class SlidingPiece < Piece



  def moves
    array = Array.new(8) {Array.new(8)}
    array.map!.with_index do |_, x|
      array.map!.with_index do |_, y|
        [x,y]
      end
    end
    moves = []

    array.each do |row|
      p row
      row.each do |tile|
        p tile
        tile.last == position.last || tile.first == position.first
        moves << tile
      end
    end
    moves
  end




  def move_dirs



  end



end

class SteppingPiece < Piece
end

class Rook < SlidingPiece
  def to_s
    " R ".colorize(color)
  end
end

class Bishop < SlidingPiece
  def to_s
    " B ".colorize(color)
  end
end

class Queen < SlidingPiece
  def to_s
    " Q ".colorize(color)
  end
end

class King < SteppingPiece
  def to_s
    " K ".colorize(color)
  end
end

class Knight < SteppingPiece
  def to_s
    " N ".colorize(color)
  end
end

class NullPiece < Piece
  def to_s
    "   "
  end
end
