# Renders the game board
class BoardRenderer
  def initialize(window)
    @window = window
    @font = Gosu::Font.new(@window, Gosu.default_font_name, 20)
    @rule_images = []

    @default_image = Gosu::Image.new(@window, image_path('default'), true)
    add_images_by_description
    add_images_by_rule
  end

  def render_board(spaces, rules)
    spaces.each_with_index do |space, index|
      label = index
      label = 'Start' if index == 0

      color = COLOR_DEFAULT
      rule = rules[index]
      image = rule_image(rule)
      image ||= @default_image if index % 3 == 0
      color = COLOR_GREEN if rule

      draw_space(label, space, color: color, image: image)
    end
  end

  private

  IMAGES_WITH_DESCRIPTION = {
    'kerkhof' => 'dead',
    'gevangenis' => 'jail',
    'brug' => 'bridge',
    'doolhof' => 'lost',
    'hotel' => 'hotel',
    'trap' => 'stairs',
    'vogelkooi' => 'cage'
  }

  IMAGES_WITH_RULE = {
    'RollAgain' => 'roll_again',
    'Well' => 'well',
    'Curvet' => 'curvet',
    'GooseSpace' => 'goose'
  }

  def add_images_by_description
    IMAGES_WITH_DESCRIPTION.each do |description, image|
      add_image(image, description: description)
    end
  end

  def add_images_by_rule
    IMAGES_WITH_RULE.each do |rule, image|
      add_image(image, rule: "Rules::#{rule}")
    end
  end

  COLOR_DEFAULT = Gosu::Color.new(0xFFf8ec58)
  COLOR_GREEN = Gosu::Color.new(0xFFf1ce4c)

  def rule_image(rule)
    return nil unless rule

    rule_image = @rule_images.find do |i|
      i[:description] == rule[:description]
    end if rule[:description]
    rule_image ||= @rule_images.find { |i| i[:rule] == rule[:rule] }
    return nil unless rule_image

    rule_image[:image]
  end

  def add_image(filename, attachment)
    image_data = {
      image: Gosu::Image.new(@window, image_path(filename), true)
    }.merge attachment
    @rule_images << image_data
  end

  def image_path(filename)
    "app/images/spaces/#{filename}.jpg"
  end

  def draw_space(label, space, color: COLOR_DEFAULT, image: nil)
    topleft_x = space[:topleft_x] - (space[:direction] == :left ? 9 : 0)
    topleft_y = space[:topleft_y] - (space[:direction] == :up ? 9 : 0)
    size_x = [:right, :left].include?(space[:direction]) ? 59 : 50
    size_y = [:up, :down].include?(space[:direction]) ? 59 : 50

    draw_square(topleft_x, topleft_y, size_x, size_y, color: color)
    image.draw(topleft_x, topleft_y, 0) if image

    @font.draw(label, topleft_x, topleft_y, 1, 1, 1, 0x40000000)
  end

  def draw_square(topleft_x, topleft_y, size_x, size_y, color: COLOR_DEFAULT)
    @window.draw_quad(
      topleft_x, topleft_y, color,
      topleft_x + size_x, topleft_y, color,
      topleft_x, topleft_y + size_y, color,
      topleft_x + size_x, topleft_y + size_y, color,
      0
    )
  end
end
