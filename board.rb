require 'colorize'
require 'byebug'
require_relative 'empty_square'
require_relative 'cursor'

class Board
  include Cursorable
  attr_accessor :cursor_pos, :grid, :pos, :freeze, :frozen_cursor, :attacked_pos

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new } }
    @cursor_pos = [0, 0]
    @freeze = false
    @frozen_cursor = cursor_pos
    @attacked_pos = cursor_pos
    populate_board
  end

  def [](pos) # move this up
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    @grid[row][col] = value
  end

  def populate_board
    royalty(0, :b)
    eight_pawns(1, :b)
    eight_pawns(6, :w)
    royalty(7, :w)
  end

  def royalty(row, color)
    pieces_array = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    grid[row].each_with_index do |cell, cell_idx|
      pos = [row, cell_idx]
      piece_class = pieces_array[cell_idx]
      self[pos] = piece_class.new(color, pos, self)
    end
  end

  def eight_pawns(row, color)
    grid[row].each_with_index do |cell, cell_idx|
      pos = [row, cell_idx]
      self[pos] = Pawn.new(color, pos, self)
    end
  end

  def on_board?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def occupied?(pos)
    self[pos].piece?
  end

  def valid_attack?(current_pos, attack_pos)
    occupied?(attack_pos) && self[attack_pos].color != self[current_pos].color
  end

  def checkmate?

  end

  # def dup #try with a flatten
  #   dup = Board.new
  #   (0..7).each do |row|
  #     (0..7).each do |piece|
  #       if self[[row, piece]].empty?
  #       dup.grid[row][piece] = self[[row, piece]].class.new
  #       else
  #         dup.grid[row][piece] = self[[row, piece]].class.new( self[[row, piece]].color, [row, piece], dup)
  #       end
  #     end
  #   end
  #   dup
  # end

  # def in_check?(color) # color under attack
  #   p "I am here!"
  #   #king can be taken on next move
  #   attacking_color = color == :b ? :w : :b
  #   king = find_king(color)
  #   grid.flatten.any? do |piece|
  #     piece.piece? && piece.color == attacking_color && piece.moves.include?(king.pos)
  #   end
  # end
  #
  # def find_king(color)
  #   grid.flatten.find do |piece|
  #     piece.class == King && piece.color == color
  #   end
  # end

  def make_move
    if self[frozen_cursor].moves.include?(attacked_pos)
      if self[attacked_pos].empty?
        self[attacked_pos] = self[frozen_cursor]
        self[attacked_pos].pos = attacked_pos
        self[frozen_cursor] = EmptySquare.new
      else
        self[attacked_pos] = self[frozen_cursor]
        self[attacked_pos].pos = attacked_pos
        self[frozen_cursor] = EmptySquare.new
        #palce holder for storing the captured pieces
      end
    #else
      # change this to exceptions later
    end
  end


  def render(color)
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        pos = [row_idx, col_idx]
        if pos == cursor_pos
          print cell.to_s.colorize(:background => :yellow)
        elsif freeze && self[frozen_cursor].moves.include?(pos) #&& self[frozen_cursor].color == color
          print cell.to_s.colorize(:background => :green)
        elsif !freeze && self[cursor_pos].moves.include?(pos) #&& self[frozen_cursor].color == color
          print cell.to_s.colorize(:background => :green)
        else
          display_square(pos)
        end
      end
      puts
    end
  end

  def display_square(pos)
    row_idx, col_idx = pos
    if (row_idx + col_idx).even?
      background = :red
    else
      background = :blue
    end
    print self[pos].to_s.colorize(background: background)
  end
end
