class Pawn < Piece
  attr_accessor :board

  PAWN_MOVES = [
    [1, 1],
    [1, 0],
    [1, -1]
  ]

  def moves
    @possible_moves = []
    check_double_step

    PAWN_MOVES.each do |candidate|
      x, y = pos[0], pos[1]
      if color == :b
        possible_pos = [x + candidate[0], y + candidate[1]]
      else
        possible_pos = [x - candidate[0], y + candidate[1]]
      end

      if board.on_board?(possible_pos)
        if (pos[1] - possible_pos[1]).abs > 0
          @possible_moves << possible_pos if board.valid_attack?(pos, possible_pos) #&& self.move_into_check?(possible_pos)
        else
          @possible_moves << possible_pos unless board.occupied?(possible_pos) #&& self.move_into_check?(possible_pos)
        end
      end
    end

    @possible_moves
  end

  def check_double_step
    double_step = color == :b ? [pos[0] + 2, pos[1]] : [pos[0] - 2, pos[1]]
    in_between_step = color == :b ? [pos[0] + 1, pos[1]] : [pos[0] - 1, pos[1]]
    if (self.color == :b && self.pos[0] == 1) || (self.color == :w && self.pos[0] == 6)
      unless board.occupied?(double_step) || board.occupied?(in_between_step)
        @possible_moves << double_step
      end
    end
  end

  def to_s
    color == :b ? " \u265F " : " \u2659 "
  end
end
