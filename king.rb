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

  def stepping_diff
    KING_MOVES
  end

  def to_s
    color == :b ? " \u265A " : " \u2654 "
  end
end
