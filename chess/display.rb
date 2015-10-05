require_relative 'board.rb'
require 'colorize'
require_relative 'cursorable.rb'
require 'byebug'


class Display
  PIECES = {
    Pawn => 'P',
    Rook => 'R',
    Knight => 'N',
    Bishop => 'B',
    King => 'K',
    Queen => 'Q'
  }
  include Cursorable
  def initialize(board, game)
    @board = board
    @game = game
    @cursor_pos = [0, 0]
  end

  # def render
  #   @board.grid.each do |row|
  #     if row.nil?
  #       puts " . " * 8
  #     else
  #       row.each do |tile|
  #         if tile.nil?
  #           print "   "
  #         else
  #           print " " + PIECES[tile.class].colorize(tile.color) + " "
  #         end
  #       end
  #       puts "\n"
  #     end
  #   end
  # end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :yellow
    elsif (i + j).odd?
      bg = :green
    else
      bg = :white
    end
    { background: bg }
  end

  def render
    system("clear")
    puts "Fill the grid!"
    puts "Arrow keys, WASD, or vim to move, space or enter to confirm."
    build_grid.each { |row| puts row.join }
  end


end
