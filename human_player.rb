class HumanPlayer
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_input
    input = $stdin.getch
  end
end
