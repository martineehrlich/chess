require_relative 'board'
require 'io/console'
require 'colorize'
require_relative 'human_player'
require_relative 'computer_player'


class Game

  attr_reader :board, :current_player, :players

  def initialize(player1, player2)
    @board = Board.new
    @players = {
      white: player1,
      black: player2
    }
    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      get_move(current_player)
      @current_player = (current_player == :white) ? :black : :white
    end

    puts board.render(current_player)
    puts "#{current_player} is checkmated."

    nil
  end

  def get_move(current_player)
    moved = false
    until moved
      system("clear")
      puts board.render(current_player)
      puts "Current player: #{current_player}"
      if board.in_check?(current_player)
        puts "#{current_player} is in check."
      end
      moved = players[current_player].make_move(board)
    end
  end

end

  begin
    puts "What type of game do you want to play?"
    puts "Press 1 for Human vs. Human"
    puts "Press 2 for Human vs. Computer"
    puts "Press 3 for Computer vs. Computer"
    input = $stdin.getch
    if input.to_i == 1
      game = Game.new(HumanPlayer.new(:white), HumanPlayer.new(:black))
    elsif input.to_i == 2
      game = Game.new(HumanPlayer.new(:white), ComputerPlayer.new(:black))
    elsif input.to_i == 3
      game = Game.new(ComputerPlayer.new(:white), ComputerPlayer.new(:black))
    elsif input == "q"
      exit
    else
      raise "Please select one of the three options."
    end
  rescue StandardError => e
    puts "#{e.message}"
    retry
  end

game.play
