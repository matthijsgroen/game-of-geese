# tell gosu when pawn is moved
module PawnListener
  attr_accessor :formatter_listener

  def location=(_value)
    super.tap { formatter_listener.update }
  end
end
