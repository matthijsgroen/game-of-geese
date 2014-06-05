AfterStep do
  DemoRenderer.new(@game).render if Cucumber::Formatter::Demo.active
end

# renders the current state of the game
class DemoRenderer
  require 'curses'

  include Curses

  def initialize(game)
    @game = game
  end

  def render
    return unless game

    render_players
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
end
