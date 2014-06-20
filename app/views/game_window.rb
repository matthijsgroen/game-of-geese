require 'gosu'
require_relative 'space_generator'

# this is the main game window
class GameWindow < Gosu::Window
  attr_accessor :spaces
  attr_accessor :update
  COLOR_BLUE = Gosu::Color.new(0xFF1EB1FA)

  def initialize
    super(800, 600, false)
    self.caption = 'Game of geese'
    @pawn_image_green = Gosu::Image.new(self, 'app/images/pawn_green.png', true)
    @spaces = []
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
  end

  def game=(game)
    @update = true
    @game = game
  end

  def draw
    draw_board(@game.board) if @game
    @pawn_image_green.draw(0, 0, 0, 0.5, 0.5)
    @font.draw(@game.inspect, 0, 0, 1, 1, 1, 0xffffff00)
  end

  def draw_board(board)
    @spaces = define_spaces(board.space_count) if @update
    @update = false

    @spaces.each_with_index do |space, index|
      draw_space(index + 1,
                 space[:topleft_x],
                 space[:topleft_y])
    end
  end

  private

  def define_spaces(space_count)
    generator = SpaceGenerator.new(600, 500, cell_spacing: 60, row_spacing: 70)
    generator.generate_spaces(space_count)
    generator.spaces
  end

  def draw_space(space, topleft_x, topleft_y)
    draw_square(topleft_x, topleft_y, 50)
    @font.draw(space.to_i, topleft_x + 20, topleft_y + 15, 1, 1, 1, 0xffffff00)
  end

  def draw_square(topleft_x = 0, topleft_y = 0, size = 50)
    draw_quad(
      topleft_x, topleft_y, COLOR_BLUE,
      topleft_x + size, topleft_y, COLOR_BLUE,
      topleft_x, topleft_y + size, COLOR_BLUE,
      topleft_x + size, topleft_y + size, COLOR_BLUE,
      0
    )
  end
end
