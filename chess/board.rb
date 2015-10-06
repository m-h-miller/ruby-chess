require_relative 'pieces'
require 'byebug'

class Board
  attr_reader :grid
    ROW_PIECES= [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    PAWNS= [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    #populate
  end

  def self.within_board?(pos)
    return true if pos.all? { |x| x.between?(0, 7) }
    false
  end

  def populate
    @grid.map!.with_index do |row, idx|

      if idx == 1
        PAWNS.map.with_index do |piece, i|
          piece.new([i, idx], self, :black)
        end
      elsif idx == 6
        PAWNS.map.with_index do |piece, i|
          piece.new([i, idx], self, :red)
        end
      elsif idx == 0
        i = 0
        ROW_PIECES.map.with_index do |piece, i|
          piece.new([i, idx], self, :black)
        end
      elsif idx == 7
        i=0
        ROW_PIECES.map.with_index do |piece, i|
          piece.new([i, idx], self, :red)
        end
      else
        nulls = []
        8.times { |i| nulls << NullPiece.new([i, idx], self, :green) }
        nulls
      end
    end
  end

  def move(start, end_pos)
    piece = self[start]
    # raise "Invalid move!!!" unless piece.valid_moves.include? end_pos

    self[end_pos] = piece.class.new(end_pos, self, piece.color)
    self[start] = NullPiece.new(start, self, :green)
  end

  def in_bounds?(pos)
    pos.all? { |x| x.between?(0, 7) }
  end

  def [](pos)
    x, y = pos
    @grid[y][x]
  end

  def []=(pos, value)
    x, y = pos
    @grid[y][x] = value
  end

  def rows
    @grid
  end

  def in_check?(player_color)
    opponent_color = player_color == :red ? :black : :red

    king = nil
    grid.each do |row|
      row.each do |piece|
        if piece.class == King && piece.color == player_color
          king = piece
        end
      end
    end

    opposing_pieces = color_pieces(opponent_color)

    opposing_pieces.any? do |piece|
      piece.generate_moves.include? king.position
    end
  end

  def color_pieces(color)
    color_pieces = []
    grid.each do |row|
      row.each do |piece|
          color_pieces << piece if piece.color == color
      end
    end
    color_pieces
  end

  def checkmate?(color)
    if in_check?(color)
      our_pieces = color_pieces(color)
      our_pieces.all? do |piece|
        piece.valid_moves.empty?
      end
    else
      false
    end
  end

  def deep_dup
    dup = Board.new
    self.grid.each_index do |y|
      self.grid.each_index do |x|
        piece = self[[x,y]]
        dup[[x,y]] = piece.class.new(piece.position.dup, dup, piece.color)
      end
    end
    dup
  end

end
