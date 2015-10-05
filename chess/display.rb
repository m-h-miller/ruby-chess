require_relative 'board.rb'
require 'colorize'
require_relative 'cursorable.rb'


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
  end

  def render
    @board.grid.each do |row|
      if row.nil?
        puts " . " * 8
      else
        row.each do |tile|
          if tile.nil?
            print " . "
          else
            print " " + PIECES[tile.class].colorize(tile.color) + " "
          end
        end
        puts "\n"
      end
    end
  end




end

a = Board.new
b = Display.new(a, nil)
b.render
