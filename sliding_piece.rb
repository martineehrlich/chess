module Slideable
  def moves
    @possible_moves = []
    direction_diff.each do |direction|
      x, y = direction[0], direction[1]
      t, m = x, y
      incremented_position = [pos[0] + x, pos[1] + y]
      while board.on_board?(incremented_position)
        break if board.occupied?(incremented_position) && board[incremented_position].color == self.color
        @possible_moves << incremented_position #unless self.move_into_check?(incremented_position)
        break if board.valid_attack?(pos, incremented_position)
        incremented_position = [pos[0] + t += x, pos[1] + m += y]
       end
    end
    @possible_moves
  end
end
