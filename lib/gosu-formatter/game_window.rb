require 'gosu'
require_relative 'space_generator'
require_relative './pawn_renderer'

# this is the main game window
class GameWindow < Gosu::Window
  attr_accessor :spaces
  attr_accessor :update
  COLOR_BLUE = Gosu::Color.new(0xFF1EB1FA)

  def initialize
    super(800, 600, false)
    self.caption = 'Game of geese'

    initialize_pawn_images

    @spaces = []
    @pawn_renderer = PawnRenderer.new
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
  end

  def initialize_pawn_images
    @pawn_images = {}
    [:green, :blue, :red, :purple, :white, :yellow].each do |color|
      path = "app/images/pawn_#{color}.png"
      @pawn_images[color] = Gosu::Image.new(self, path, true)
    end
  end

  def game_struct=(game)
    @update = true
    @game = game

    @pawn_renderer.update_game(game)
  end

  def update
    @pawn_renderer.transition
  end

  def draw
    return unless @game
    draw_board(@game[:board])
    @font.draw(@game[:die_value], 120, 120, 1, 1, 1, 0xffffff00)

    draw_players(@game[:players], 90, 150)
    @pawn_renderer.draw_pawns(self)
  end

  def draw_players(players, x, y)
    players.each_with_index do |p, i|
      image = @pawn_images[p[:pawn][:color]]
      image.draw(x, y + (30 * i), 0, 0.5, 0.5) if image

      @font.draw(p[:name], x + 30, y + (30 * i), 1, 1, 1,
                 p[:active] ? 0xffffffff : 0xff00ff00)
    end
  end

  def draw_pawn(color, x, y)
    image = @pawn_images[color]
    image.draw(x, y, 2, 0.5, 0.5)
  end

  def locate_pawns(game)
    locations = {}
    game[:players].each do |p|
      pawn = p[:pawn]
      location = [pawn[:location], 63].min
      locations[location] ||= []
      locations[location].push pawn[:color]
    end
    locations
  end

  def draw_board(board)
    @spaces = define_spaces(board[:space_count]) if @update
    @update = false

    @spaces.each_with_index do |space, index|
      label = index
      label = 'Start' if index == 0

      draw_space(
        label,
        space
      )
    end
  end

  Space = Struct.new(:x, :y)

  def space_position(index)
    s = @spaces[[index, @spaces.size - 1].min]
    Space.new(s[:topleft_x], s[:topleft_y])
  end

  private

  def define_spaces(space_count)
    generator = SpaceGenerator.new(700, 500, cell_spacing: 60, row_spacing: 70)
    generator.generate_spaces(space_count + 1)
    generator.spaces
  end

  def draw_space(label, space)
    topleft_x = space[:topleft_x] - (space[:direction] == :left ? 9 : 0)
    topleft_y = space[:topleft_y] - (space[:direction] == :up ? 9 : 0)
    size_x = [:right, :left].include?(space[:direction]) ? 59 : 50
    size_y = [:up, :down].include?(space[:direction]) ? 59 : 50

    draw_square(topleft_x, topleft_y, size_x, size_y)
    @font.draw(label, topleft_x, topleft_y, 1, 1, 1, 0x40000000)
  end

  def draw_square(topleft_x, topleft_y, size_x, size_y, color: COLOR_BLUE)
    draw_quad(
      topleft_x, topleft_y, color,
      topleft_x + size_x, topleft_y, color,
      topleft_x, topleft_y + size_y, color,
      topleft_x + size_x, topleft_y + size_y, color,
      0
    )
  end
end
