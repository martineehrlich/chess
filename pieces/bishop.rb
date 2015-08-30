require_relative 'piece'
require_relative 'slideable'

class Bishop < Piece
  include Slideable

  def move_dirs
    diagonal_dirs
  end

  def symbols
    { white: '♗', black: '♝' }
  end
end
