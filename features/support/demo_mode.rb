AfterStep do
  DemoRenderer.new(@game).render if Cucumber::Formatter::Demo.active
end

# renders the current state of the game
class DemoRenderer
  require 'curses'

  include Curses

  def initialize(game)
    @game = game

    @board_window = Window.new(lines - 14, cols * (2 / 3.0), 12, 0)
  end

  def render
    return unless game

    render_players
    render_board
    refresh
  end

  private

  attr_reader :game

  def render_players
    attron(color_pair(COLOR_WHITE))
    attroff(A_BOLD)
    setpos(4, 4)
    addstr('Players:')
    game.players.each_with_index do |p, i|
      attroff(A_BOLD)
      attron(A_BOLD) if p == game.active_player
      setpos(5 + i, 4)
      addstr("- #{p.name} (#{p.age}) => #{p.pawn.color}")
    end
  end

  def render_board
    @board_window.clear
    return unless game.board

    # spaces = game.board.space_count
    spaces = 31

    @board_window.box('|', '-')
    @board_window.setpos(@board_window.maxy - 5, 3)
    startx, starty = @board_window.curx, @board_window.cury
    endx, endy = startx, starty
    direction = :right

    (0..spaces).each do |i|
      contents = space_contents(i)
      direction = :top if endx + contents.length + 1 > @board_window.maxx

      if direction == :right
        startx = endx + 1
      elsif direction == :top
        starty -=  4
      end
      @board_window.setpos(starty, startx)
      @board_window.addstr(contents)
      endx, endy = @board_window.curx, @board_window.cury

      # surround with box
      draw_box(startx, starty, endx, endy)
    end

    @board_window.refresh
  end

  def space_contents(index)
    if index == 0
      '  start  '
    else
      format('  %2d  ', index)
    end
  end

  def draw_box(startx, starty, endx, endy)
    @board_window.setpos(starty - 2, startx)
    @board_window.addstr('-' * (endx - startx))
    (starty - 1 .. endy + 1).each do |y|
      @board_window.setpos(y, startx - 1)
      @board_window.addstr('|')
      @board_window.setpos(y, endx)
      @board_window.addstr('|')
    end
    @board_window.setpos(endy + 2, startx)
    @board_window.addstr('-' * (endx - startx))
  end
end
