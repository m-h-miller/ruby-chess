


module SteppingPiece
  def generate_moves
    moves = []
    # debugger
    self.class::MOVES.each do |diff_x, diff_y|
      current_pos = self.position

      new_pos = [current_pos[0] + diff_x, current_pos[1] + diff_y]
      next unless Board.within_board?(new_pos)
      next if @board[new_pos].color == self.color
      moves << new_pos

    end
    moves
  end

end
