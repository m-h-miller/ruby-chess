require_relative 'board.rb'

class Piece

  def valid_moves(start)
    moves = []
  end
end

class Pawn < Piece
end

class SlidingPiece < Piece
end

class SteppingPiece < Piece
end

class Rook < SlidingPiece
end

class Bishop < SlidingPiece
end

class Queen < SlidingPiece
end

class King < SteppingPiece
end

class Knight < SteppingPiece
end
