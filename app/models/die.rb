# A standard die with 6 faces
class Die
  attr_reader :value

  def roll
    @value = rand(1..6)
  end
end
