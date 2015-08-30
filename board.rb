require 'colorize'
require 'byebug'
require_relative 'cursor'
require_relative 'all_pieces'
require_relative 'emptysquare'

class Board
  attr_accessor :cursor_pos, :grid, :pos, :selected_pos

  def initialize(starting_board = true)
    @cursor_pos = [0, 0]
    @selected_pos = nil
    populate_board(starting_board)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row,col = pos
    @grid[row][col] = value
  end

  def add_piece(piece, pos)
    raise 'position not empty' unless self[pos].empty?
    self[pos] = piece
  end

  def populate_board(starting_board)
    @grid = Array.new(8) { Array.new(8) {EmptySquare.new}}
    return unless starting_board
    royalty(0, :black)
    eight_pawns(1, :black)
    eight_pawns(6, :white)
    royalty(7, :white)
  end

  def royalty(row, color)
    pieces_array = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

    grid[row].each_with_index do |cell, cell_idx|
      pos = [row, cell_idx]
      piece_class = pieces_array[cell_idx]
      piece_class.new(color, self, pos)
    end
  end

  def eight_pawns(row, color)
    grid[row].each_with_index do |cell, cell_idx|
      pos = [row, cell_idx]
      Pawn.new(color, self, pos)
    end
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? do |p|
      p.color != color && p.moves.include?(king_pos)
    end
  end

  def pieces
    @grid.flatten.select {|cell| cell.is_a? Piece}
  end

  def find_king(color)
    king = pieces.find { |p| p.color == color && p.is_a?(King) }
    king || (raise 'king not found?')
  end

  def move_piece(turn_color, from_pos = selected_pos, to_pos = cursor_pos)
  raise 'from position is empty' if self[from_pos].empty?
  piece = self[from_pos]
  if piece.color != turn_color
    raise 'move your own piece'
  elsif !piece.moves.include?(to_pos)
    raise 'piece does not move like that'
  elsif !piece.valid_moves.include?(to_pos)
    raise 'cannot move into check'
  end
  move!(from_pos, to_pos)
end

def select_pos
  @selected_pos = @cursor_pos
end

def unselect_pos
  @selected_pos = nil
end

def move!(start_pos = selected_pos, end_pos = cursor_pos)
   current_piece = self[start_pos]
   self[end_pos] = current_piece
   self[start_pos] = EmptySquare.new
   current_piece.pos = end_pos
 end

def checkmate?(color)
  return false unless in_check?(color)

  pieces.select { |p| p.color == color }.all? do |piece|
    piece.valid_moves.empty?
  end
end

def dup
  new_board = Board.new(false)

  pieces.each do |piece|
    piece.class.new(piece.color, new_board, piece.pos)
  end

  new_board
end

def render(color)
    grid.each_with_index do |row, row_idx|
      row.each_with_index do |cell, col_idx|
        pos = [row_idx, col_idx]
      if pos == selected_pos
        print (cell.render).colorize(:background => :green)
      elsif pos == cursor_pos
          print (cell.render).colorize(:background => :yellow)
      elsif self[cursor_pos].moves.include?(pos) && color == self[cursor_pos].color
          print (cell.render).colorize(:background => :cyan)
      # elsif self[cursor_pos].moves.include?(pos) && color == self[cursor_pos].color
      #     print (cell.render).colorize(:background => :cyan)
      else
          display_square(pos)
        end
      end
      puts
    end
    nil
end

  def cursor_up
    if cursor_pos.first > 0
      new_pos = [cursor_pos.first - 1, cursor_pos.last]
      @cursor_pos = new_pos
    end
  end

  def cursor_down
    if cursor_pos.first < 7
      new_pos = [cursor_pos.first + 1, cursor_pos.last]
      @cursor_pos = new_pos
    end
  end

  def cursor_right
    if cursor_pos.last < 7
      new_pos = [cursor_pos.first, cursor_pos.last + 1]
      @cursor_pos = new_pos
    end
  end

  def cursor_left
    if cursor_pos.last > 0
      new_pos = [cursor_pos.first, cursor_pos.last - 1]
      @cursor_pos = new_pos
    end
  end


  def display_square(pos)
    row_idx, col_idx = pos
    if (row_idx + col_idx).even?
      background = :red
    else
      background = :blue
    end
      print (self[pos].render).colorize(background: background)
  end
end
