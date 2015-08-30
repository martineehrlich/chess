require_relative 'board'
require 'io/console'
require 'colorize'
require_relative 'cursor'
require_relative 'human_player'
require_relative 'computer_player'


class Game

  attr_reader :board, :current_player, :players

  def initialize
    @board = Board.new
    @players = {
      white: HumanPlayer.new(:white, @board),
      black: ComputerPlayer.new(:black, @board)
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
      moved = players[current_player].make_move
    end
  end

end


game = Game.new
game.play
