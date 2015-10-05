require_relative 'pieces.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

    row_pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    # PIECES = [Rook, Knight, Bishop...]
    #
    # PIECES.map { |piece| piece.new }

    @grid.map!.with_index do |row, idx|

        if idx == 1
          pawns = []
          8.times { pawns << Pawn.new(:white) }
          pawns
        elsif idx == 6
          pawns = []
          8.times { pawns << Pawn.new(:black) }  
          pawns
        elsif idx == 0
          row_pieces.map do |piece|
            piece.new(:white)
          end
        elsif idx == 7
          row_pieces.map do |piece|
            piece.new(:black)
          end
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

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end


end


c = Board.new.grid
puts c
