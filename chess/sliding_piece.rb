module SlidingPiece

  # everey piece has a MOVES constant self.class::MOVESff
  def generate_moves
    moves = []
    # debugger
    self.class::MOVES.each do |diff_x, diff_y|
      current_pos = self.position
      #byebug
      while Board.within_board?(current_pos)
        new_pos = [current_pos[0] + diff_x, current_pos[1] + diff_y]
        break unless Board.within_board?(new_pos)

        if !@board[new_pos].empty?       #adds capturing square
          if @board[new_pos].color != self.color
            moves << new_pos
          end
          break
        end

        moves << new_pos
        current_pos = new_pos

      end
    end
    moves
  end

end
