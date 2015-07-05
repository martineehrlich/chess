class Queen < Piece
include Slideable
  QUEEN_DIRS = [
    [1, 1],
    [1,-1],
    [-1,1],
    [-1,-1],
    [0 , 1],
    [1,  0],
    [0, -1],
    [-1, 0]
  ]

  def direction_diff
    QUEEN_DIRS
  end

  def to_s
    color == :b ? " \u265B " : " \u2655 "
  end
end
