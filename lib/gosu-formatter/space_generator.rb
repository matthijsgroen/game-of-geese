# Generates locations for spaces on the Game of Goose board
class SpaceGenerator
  DIRECTIONS = [:right, :down, :left, :up]

  def initialize(max_x, max_y, row_spacing:, cell_spacing:)
    @row_spacing = row_spacing
    @cell_spacing = cell_spacing
    set_boundaries(max_x, max_y)
    @spaces = []
    @direction = DIRECTIONS.first
    @topleft = { x: 0, y: 0 }
  end

  attr_reader :spaces

  def generate_spaces(count)
    count.times do
      @spaces << {
        topleft_x: @topleft[:x],
        topleft_y: @topleft[:y],
        direction: @direction
      }
      draw_next_tile
    end
  end

  private

  def draw_next_tile
    case @direction
    when :right then draw_tile_right
    when :down  then draw_tile_down
    when :left  then draw_tile_left
    when :up    then draw_tile_up
    end
  end

  def set_boundaries(max_x, max_y)
    @boundaries = {
      top: @row_spacing,
      left: 0,
      right: max_x,
      bottom: max_y
    }
  end

  def draw_tile_right
    @topleft[:x] += @cell_spacing
    when_out_of_boundaries do
      @boundaries[:right] -= @row_spacing
    end
  end

  def draw_tile_down
    @topleft[:y] += @cell_spacing
    when_out_of_boundaries do
      @boundaries[:bottom] -= @row_spacing
    end
  end

  def draw_tile_left
    @topleft[:x] -= @cell_spacing
    when_out_of_boundaries do
      @boundaries[:left] += @row_spacing
    end
  end

  def draw_tile_up
    @topleft[:y] -= @cell_spacing
    when_out_of_boundaries do
      @boundaries[:top] += @row_spacing
    end
  end

  def when_out_of_boundaries
    return unless out_of_boundaries?
    yield
    next_direction
  end

  def out_of_boundaries?
    case @direction
    when :up    then @topleft[:y] <= @boundaries[:top]
    when :left  then @topleft[:x] <= @boundaries[:left]
    when :down  then @topleft[:y] >= @boundaries[:bottom]
    when :right then @topleft[:x] >= @boundaries[:right]
    end
  end

  def next_direction
    index = (DIRECTIONS.index(@direction) + 1) % DIRECTIONS.length
    @direction = DIRECTIONS[index]
  end
end
