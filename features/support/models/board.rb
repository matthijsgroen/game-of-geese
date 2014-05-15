# The gameboard with spaces to move pawns across
class Board
  attr_reader :spaces

  def initialize(spaces)
    @spaces = spaces
  end

  def set_rules_for_space(_rule, _space)
  end
end
