class EmptySquare
  def empty?
    true
  end

  def render
    '   '
  end

  def color
    nil
  end

  def valid_move?(end_pos)
    false
  end

  def dup(board)
    EmptySquare.new
  end

  def king?
    false
  end

  def moves
    []
  end

end
