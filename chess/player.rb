require_relative "display"

class Player
  def initialize(board)
    @display = Display.new(board, nil)
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end
end


b = Board.new
d = Display.new(b, nil)
pl = Player.new(b)

while true
  pl.move
end
