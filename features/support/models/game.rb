# Our 'concept' of the game, maintaining the rules of the game
class Game
  attr_reader :players

  def initialize
    @players = []
  end

  def join(person, pawn)
    player = person.extend Player
    player.pawn = pawn
    @players.push player
  end

  # method name suggestion from:
  # http://english.stackexchange.com/questions/117734
  def active_player
    # the youngest player may start
    @players.sort do |a, b|
      a.age <=> b.age
    end.first
  end
end
