# The gameboard with spaces to move pawns across
class Board
  attr_reader :spaces

  def initialize(spaces)
    @spaces = spaces
  end
end
