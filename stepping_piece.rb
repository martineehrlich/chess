require 'byebug'

module Stepable #where to require/include
  def moves
    @possible_moves = []
    stepping_diff.each do |position|
      x, y = position[0], position[1]
      candidate = [x + pos[0], y + pos[1]]
      if board.on_board?(candidate)
        if board.valid_attack?(pos, candidate) || !board.occupied?(candidate)
          @possible_moves << candidate 
        end
      end
    end
    @possible_moves
  end
end
