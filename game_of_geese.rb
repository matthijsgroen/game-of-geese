require 'gosu'
require_relative 'app/models/board'
require_relative 'app/models/die'
require_relative 'app/models/game'
require_relative 'app/models/pawn'
require_relative 'app/models/person'

class Circle
  attr_reader :columns, :rows

  def initialize radius
    @columns = @rows = radius * 2
    lower_half = (0...radius).map do |y|
      x = Math.sqrt(radius**2 - y**2).round
      right_half = "#{"\xff" * x}#{"\x00" * (radius - x)}"
      "#{right_half.reverse}#{right_half}"
    end.join
    @blob = lower_half.reverse + lower_half
    @blob.gsub!(/./) { |alpha| "\xff\xff\xff#{alpha}" }
  end

  def to_blob
    @blob
  end
end


class GameWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = "Game of geese"
  end

  def update
    if button_down? Gosu::KbEscape
      puts "hi"
      close
    end
  end
end

window = GameWindow.new
# window.show # triggers event loop
Thread.new do
  window.show
end

puts 'hello'

sleep 7