#:nodoc:
class PawnRenderer
  def initialize(window)
    @pawns = {}
    initialize_pawn_images(window)
  end

  def update_game(game)
    pawns = game[:players].map { |p| p[:pawn] }
    if @pawns.size != pawns.size
      reset_pawns(pawns)
    else
      update_pawns(pawns)
    end
  end

  def transition
    @pawns.each do |_color, p|
      p[:transition] += 0.05
      p[:transition] = 1.0 if p[:transition] > 1.0
    end
  end

  def draw_pawn(color, x, y)
    image = @pawn_images[color]
    image.draw(x, y, 2, 0.5, 0.5)
  end

  def draw_pawns(window)
    @pawns.each do |color, p|
      x, y = calculate_pawn_position(p, window)
      draw_pawn(color, x, y)
    end
  end

  private

  def update_pawns(pawns)
    pawns.each do |p|
      color = p[:color]
      pawn = @pawns[color]
      next if pawn[:destination] == p[:location]
      pawn[:source] = pawn[:destination]
      pawn[:destination] = p[:location]
      pawn[:transition] = 0.0
    end
  end

  def calculate_pawn_position(pawn, window)
    source = window.space_position(pawn[:source])
    destination = window.space_position(pawn[:destination])
    delta_x = destination.x - source.x
    delta_y = destination.y - source.y

    x = source.x + (delta_x * pawn[:transition]) + (pawn[:index] * 5)
    y = source.y + (delta_y * pawn[:transition]) + (pawn[:index] * 3)
    [x, y]
  end

  def reset_pawns(pawns)
    @pawns = {}
    pawns.each_with_index do |p, index|
      color = p[:color]
      @pawns[color] = {
        index: index,
        destination: p[:location],
        source: p[:location],
        transition: 0.0
      }
    end
  end

  def initialize_pawn_images(window)
    @pawn_images = {}
    [:green, :blue, :red, :purple, :white, :yellow].each do |color|
      path = "app/images/pawn_#{color}.png"
      @pawn_images[color] = Gosu::Image.new(window, path, true)
    end
  end
end
