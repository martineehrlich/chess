require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
include Slideable

  def move_dirs
     horizontal_dirs
  end

  def symbols
     { white: '♖', black: '♜' }
  end
end
