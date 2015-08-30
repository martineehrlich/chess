require_relative 'piece'

class Pawn < Piece

    def moves
      move_forward + attack_moves
    end

    def move_forward
      x, y = pos
      step = [x + forward_dir, y]
      return [] unless board[step].empty?
      steps = [step]
    two_step = [x + 2 * forward_dir, y]
    steps << two_step if at_start_row? && board[two_step].empty?
    steps
    end

    def at_start_row?
      pos[0] == ((color == :white) ? 6 : 1)
    end

    def forward_dir
      (color == :white) ? -1 : 1
    end

    def attack_moves
    i, j = pos

    side_moves = [[i + forward_dir, j - 1], [i + forward_dir, j + 1]]

    side_moves.select do |new_pos|
      threatened_piece = board[new_pos]
      threatened_piece.is_a?(Piece) && threatened_piece.color != color
    end
  end

  def symbols
    { white: '♙', black: '♟' }
  end
end
