require_relative 'pieces.rb'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }

    @grid.map!.with_index do |row, idx|

        if idx == 1 || idx == 6
          [Pawn.new] * 8
        elsif idx == 0 || idx == 7
          [Rook.new,
          Knight.new,
          Bishop.new,
          Queen.new,
          King.new,
          Bishop.new,
          Knight.new,
          Rook.new]
        end

    end
  end

  def move(start, end_pos)
    active_piece = @grid[start]
    if @grid[start].nil?
      raise MoveError.new 'No piece there'
    elsif
      active_piece.valid_moves(start).include?(end_pos)
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
