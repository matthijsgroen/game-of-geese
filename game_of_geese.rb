require 'gosu'
require_relative 'app/models/board'
require_relative 'app/models/die'
require_relative 'app/models/game'
require_relative 'app/models/pawn'
require_relative 'app/models/person'
require_relative 'app/models/roles/player_circle'
require_relative 'app/models/roles/player'

require 'drb/drb'

class GameWindow < Gosu::Window
  attr_accessor :board
  attr_accessor :spaces
  COLOR_BLUE = Gosu::Color.new(0xFF1EB1FA)

  def initialize
    super(800, 600, false)
    self.caption = "Game of geese"
    #@pawn_image = Gosu::Image.new(self, "pawn.png", true)
    @spaces = []
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    @spaces = []
  end


  def draw
    draw_board if @board
  end

  def draw_board
    topleft_x, topleft_y = 0, 0
    max_x = 600
    max_y = 500
    min_x, min_y = 0, 0
    row_spacing = 70
    cell_spacing = 60
    direction = :right

    (1..@board.space_count).each do |space|
      #draw_space(space, topleft_x, topleft_y)
      @spaces << {space: space, topleft_x: topleft_x, topleft_y: topleft_y}
      if direction == :right
        topleft_x = topleft_x + cell_spacing
        if topleft_x < max_x
          direction = :right
        else
          direction = :down
          max_x = max_x - row_spacing
        end
      elsif direction == :down
        topleft_y = topleft_y + cell_spacing
        if topleft_y < max_y
          direction = :down
        else
          direction = :left
          max_y = max_y - row_spacing
        end
      elsif direction == :left
        topleft_x = topleft_x - cell_spacing
        if topleft_x > min_x
          direction = :left
        else
          direction = :up
          min_y = min_y + row_spacing
        end
      elsif direction == :up
        topleft_y = topleft_y - cell_spacing
        if topleft_y > min_y
          direction = :up
        else
          direction = :right
          min_x = min_x + row_spacing
        end
      end
    end

    @spaces.each{ |space| draw_space(space[:space], space[:topleft_x], space[:topleft_y]) }

  end

  def create_board(space_count)
    @board = Board.new space_count
  end

  def draw_space(space, topleft_x, topleft_y)
    draw_square(topleft_x, topleft_y, 50)
    @font.draw(space.to_i, topleft_x + 20, topleft_y + 15, 1, 1, 1, 0xffffff00)
  end

  def draw_square(topleft_x = 0, topleft_y = 0, size = 50)
    draw_quad(
        topleft_x, topleft_y, COLOR_BLUE,
        topleft_x+size, topleft_y, COLOR_BLUE,
        topleft_x, topleft_y+size, COLOR_BLUE,
        topleft_x+size, topleft_y+size, COLOR_BLUE,
        0)
  end

end


window = GameWindow.new
DRb.start_service("druby://localhost:8787", window)
window.show


