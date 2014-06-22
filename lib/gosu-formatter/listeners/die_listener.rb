# tell gosu when die is rolled
module DieListener
  attr_accessor :formatter_listener

  def roll
    super.tap { formatter_listener.update }
  end
end
