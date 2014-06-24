require 'gosu'
require_relative 'space_generator'
require_relative './renderers/pawn_renderer'
require_relative './renderers/die_renderer'
require_relative './renderers/board_renderer'

# this is the main game window
class GameWindow < Gosu::Window
  attr_accessor :spaces
  attr_accessor :update
  COLOR_WHITE = Gosu::Color.new(0xFFFFFFFF)

  def initialize
    super(800, 600, false)
    self.caption = 'Game of geese'

    @spaces = []
    @pawn_renderer = PawnRenderer.new(self)
    @die_renderer = DieRenderer.new(self)
    @board_renderer = BoardRenderer.new(self)
    @font = Gosu::Font.new(self, Gosu.default_font_name, 20)
  end

  def game_struct=(game)
    @update = true
    @game = game

    @pawn_renderer.update_game(game)
    @die_renderer.update_game(game)
  end

  def update
    @pawn_renderer.transition
    @die_renderer.update
  end

  def draw
    return unless @game
    clear
    draw_board(@game[:board])
    draw_players(@game[:players], 90, 150)
    @die_renderer.draw_die(400, 250)
    @pawn_renderer.draw_pawns(self)
  end

  def draw_players(players, x, y)
    players.each_with_index do |p, i|
      @pawn_renderer.draw_pawn(p[:pawn][:color], x, y + (30 * i))
      label = p[:name]
      label += ' <' if p[:active]
      label += ' WINNAAR!' if p[:winner]

      @font.draw(label, x + 30, y + (30 * i), 1, 1, 1,
                 p[:active] ? 0xff000000 : 0x9f000000)
    end
  end

  def draw_board(board)
    @spaces = define_spaces(board[:space_count]) if @update
    @update = false

    @board_renderer.render_board(@spaces, @game[:rules])
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

  def clear
    draw_quad(
      0,    0,    COLOR_WHITE,  800,  0,    COLOR_WHITE,
      800,  600,  COLOR_WHITE,  0,    600,  COLOR_WHITE,
      0
    )
  end
end
