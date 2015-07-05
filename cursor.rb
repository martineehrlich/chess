module Cursorable
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

  def select
    if @freeze == false
      @freeze = true
      @frozen_cursor = cursor_pos
    else
      @freeze = false
      @attacked_pos = cursor_pos
    end
  end
end
