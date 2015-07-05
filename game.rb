require_relative 'board'
require 'io/console'
require 'colorize'
require_relative 'cursor'
require_relative 'piece'
require_relative 'sliding_piece'
require_relative 'stepping_piece'
require_relative 'bishop'
require_relative 'knight'
require_relative 'king'
require_relative 'queen'
require_relative 'pawn'
require_relative 'rook'
require_relative 'human_player'

class Game
  MOVEMENTS = {
    'w' => :cursor_up,
    'a' => :cursor_left,
    's' => :cursor_down,
    'd' => :cursor_right,
    'q' => :exit,
    't' => :select
    # 's' => :save
  }

  attr_accessor :board, :turn, :players

  def initialize(player1, player2)
    @board = Board.new
    @players = { :b => player1, :w  => player2 }
    @turn = :w
  end

  def play
    until game_over?
      move_selection

    end
  end

  def move_selection
    render
    puts "It's #{players[turn].name} turn"
    # input = players[turn].get_input
    input = $stdin.getch
    read_input(input)
    board.make_move
    system("clear")
    # if board.frozen_cursor != board.attacked_pos

  end
  #change this so people have another chance to make a move
#action(get_input)

  def render
    board.render(:b)
  end

  def game_over?
    false
  end

  def read_input(input)
    board.send(MOVEMENTS[input])
  end
end
player1 = HumanPlayer.new("white")
player2 = HumanPlayer.new("black")
game = Game.new(player1, player2)
game.play
