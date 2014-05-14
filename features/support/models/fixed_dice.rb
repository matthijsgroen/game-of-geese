# A fixed dice that always returns a pre-defined value
class FixedDice
  attr_reader :value

  def initialize(fixed_value)
    @value = fixed_value
  end

  def roll
  end
end
