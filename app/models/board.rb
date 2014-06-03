# The gameboard with spaces to move pawns across
class Board
  attr_reader :space_count

  def initialize(space_count)
    @space_count = space_count
    @labels = {}
  end

  def set_label_for_space(label, space)
    @labels[space] = label
  end

  def label_for_space(space)
    @labels[space]
  end
end
