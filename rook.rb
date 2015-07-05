class Rook < Piece
include Slideable

  ROOK_DIRS = [
    [0 , 1],
    [1,  0],
    [0, -1],
    [-1, 0]
  ]

  def direction_diff
    ROOK_DIRS
  end

  def to_s
    color == :b ? " \u265C " : " \u2656 "
  end
end
