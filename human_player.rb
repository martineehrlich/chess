class HumanPlayer

  attr_accessor :color, :board

  def initialize(color, board)
    @color = color
    @board = board
  end

  def make_move
    begin
      action = $stdin.getch
      moved = read_input(action)
    rescue StandardError => e
      puts "#{e.message}"
      board.unselect_pos
      retry
    end

    moved
  end

  def read_input(input)
      case input
      when 'q'
        exit
      when 'w'
        board.cursor_up
      when 'a'
        board.cursor_left
      when 's'
        board.cursor_down
      when 'd'
        board.cursor_right
      when "\r"
        if board.selected_pos.nil?
          board.select_pos
        else
          board.move_piece(color)
          board.unselect_pos
          return true
        end
      end

      false
    end

end
