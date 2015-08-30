class Piece
  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    raise 'invalid color' unless [:white, :black].include?(color)
    raise 'invalid pos' unless board.valid_pos?(pos)
    @color = color
    @pos = pos
    @board = board
    board.add_piece(self, pos)
  end

  def valid_moves
    moves.reject { |to_pos| move_into_check?(to_pos) }
  end

  def render
    " " + symbols[color] + " "
  end

  def symbols
  end

  def empty?
    false
  end

  def move_into_check?(to_pos)
      test_board = board.dup
      test_board.move!(pos, to_pos)
      test_board.in_check?(color)
  end

  def check_king?(from_pos, to_pos)
    test_board = board.dup
    test_board.move!(from_pos, to_pos)
    test_board.in_check?(:white)
  end
end
