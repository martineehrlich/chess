class Bishop < Piece
  include Slideable
  BISHOP_DIRS = [
    [1, 1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def direction_diff
    BISHOP_DIRS
  end

  def to_s
    color == :b ? " \u265D " : " \u2657 "
  end
end
