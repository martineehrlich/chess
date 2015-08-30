require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  include Stepable
  KNIGHT_MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]
  ]

  def move_diffs
    KNIGHT_MOVES
  end

  def symbols
  { white: '♘', black: '♞' }
end
end
