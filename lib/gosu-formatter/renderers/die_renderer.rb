#:nodoc:
class DieRenderer
  def initialize(window)
    @die = { value: 1, x: 0, y: 0 }
    @rolling = false
    @value = 1
    @counter = 0
    initialize_die_images(window)
  end

  def update_game(game)
    return unless game
    @rolling = game[:die][:rolling]
    if @rolling
      @die[:x] = 0
      @die[:y] = 0
      @direction = rand(0..7)
      @counter = 0
    end
    @value = game[:die][:value]
  end

  def update
    @counter += 1

    return unless @counter % 10 == 0
    @die[:value] = @value

    return unless @rolling
    @die[:value] = rand(1..6) if @counter < 40

    move_die unless @counter > 40
  end

  def move_die
    # 0 1 2
    # 7   3
    # 6 5 4

    @die[:x] += 1 if [2, 3, 4].include? @direction
    @die[:y] += 1 if [6, 5, 4].include? @direction
    @die[:x] -= 1 if [0, 7, 6].include? @direction
    @die[:y] -= 1 if [0, 1, 2].include? @direction
  end

  def draw_die(x, y)
    return unless @die[:value]
    die = @die_images[@die[:value]]
    die.draw(x + (@die[:x] * 30), y + (@die[:y] * 30), 2, 0.5, 0.5)
  end

  private

  def initialize_die_images(window)
    @die_images = {}
    (1..6).each do |value|
      path = "app/images/die#{value}.png"
      @die_images[value] = Gosu::Image.new(window, path, true)
    end
  end
end
