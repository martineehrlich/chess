class ComputerPlayer
  attr_accessor :color, :board, :piece

  def initialize(color)
    @color = color
  end

  def make_move(board)
    begin
      start_pos, end_pos = get_start_pos(color, board)
      board.move_piece(color, start_pos, end_pos)
    rescue StandardError => e
      puts "#{e.message}"
      retry
    end
    sleep(1)
  end

  def get_start_pos(color, board)
    check = try_for_check(board)
    if check.length > 0
    @piece = check.sample
      return [@piece[0].pos, @piece[1]]
    else
      options = board.pieces.select { |piece| piece.color == color && piece.valid_moves.length > 0}
      @piece = options.sample
      return [@piece.pos, @piece.valid_moves.sample]
    end
  end

  def try_for_check(board)
    options = board.pieces.select { |piece| piece.color == color}
    possible_moves = []
    options.each do |piece|
    moves = piece.valid_moves.select do |move|
        piece.check_king?(piece.pos, move)
      end
      if moves.length > 0
        moves.each do |move|
          possible_moves.push([piece, move])
        end
      end
    end
    possible_moves.select {|move| move.nil? == false}
  end

  def get_end_pos
    @piece.valid_moves.sample
  end

end
