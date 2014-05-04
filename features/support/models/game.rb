# Our 'concept' of the game, maintaining the rules of the game
class Game
  attr_reader :players

  def initialize
    @players = []
    @players.extend PlayerCircle
  end

  def join(person, pawn)
    player = person.extend Player
    player.pawn = pawn
    @players.push player
  end

  # method name suggestion from:
  # http://english.stackexchange.com/questions/117734
  def active_player
    @active_player ||= players.start
  end

  def play_turn
    @active_player = @players.next_after active_player
  end
end
