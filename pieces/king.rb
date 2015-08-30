require_relative 'piece'
require_relative 'stepable'

class King < Piece
  include Stepable
  KING_MOVES = [
    [-1, 0],
    [1,  0],
    [0,  1],
    [0, -1],
    [1,  1],
    [-1, -1],
    [1, -1],
    [-1,  1]
  ]

  def move_diffs
    KING_MOVES
  end

  def symbols
     { white: '♔', black: '♚' }
   end
end
