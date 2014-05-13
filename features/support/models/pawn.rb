# A physical pawn on the playing field
class Pawn
  attr_reader :color

  def initialize(attributes)
    @color = attributes[:color]
  end
end
