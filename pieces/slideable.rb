require 'byebug'

module Slideable
  HORIZONTAL_DIRS = [
   [-1, 0],
   [0, -1],
   [0, 1],
   [1, 0]
 ]

 DIAGONAL_DIRS = [
   [-1, -1],
   [-1, 1],
   [1, -1],
   [1, 1]
 ]

 def horizontal_dirs
   HORIZONTAL_DIRS
 end

 def diagonal_dirs
   DIAGONAL_DIRS
 end

 def moves
   moves = []
   move_dirs.each do |direction|
     x, y = direction[0], direction[1]
     moves.concat(add_moves(x,y))
    end
   moves
 end

  def add_moves(x, y)
    moves = [];
    i, j = pos
    loop do
      i += x
      j += y
      pos = [i ,j]
    break unless board.valid_pos?(pos)

    if board[pos].empty?
      moves << pos
    else
      moves << pos if board[pos].color != color
      break
    end
  end
  moves
 end

  def move_dirs
    raise NotImplementedError
  end
end
