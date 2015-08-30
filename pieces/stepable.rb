module Stepable
  def moves
    move_diffs.each_with_object([]) do |(dx, dy), moves|
      cur_x, cur_y = pos
      pos = [cur_x + dx, cur_y + dy]

      next unless board.valid_pos?(pos)

      if board[pos].empty?
        moves << pos
      elsif board[pos].color != color
        moves << pos
      end
    end
  end


  def move_diffs
    raise "error"
  end
end
