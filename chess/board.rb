require_relative 'pieces'

class Board
  attr_reader :grid
    ROW_PIECES= [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    PAWNS= [Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn, Pawn]

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end


  def self.within_board?(pos)
    return true if pos.all? { |x| x.between?(0, 7) }
    false
  end





  def populate_board
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
        8.times { |i| nulls << NullPiece.new([i, idx], self, :red) }
        nulls
      end
    end
  end



  def move(start, end_pos)
    active_piece = @grid[start]
    if @grid[start].nil?
      raise MoveError.new 'No piece there'
    elsif !active_piece.valid_moves(start).include?(end_pos)
      raise MoveError.new 'Piece can\'t move there'
    else
      @grid[end_pos] = active_piece
      @grid[start] = nil
    end
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
    @grid[x][y] = value
  end

  def rows
    @grid
  end

end
