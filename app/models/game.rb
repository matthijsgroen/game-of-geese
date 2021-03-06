# Our 'concept' of the game, maintaining the rules of the game
class Game
  attr_reader :players
  attr_accessor :die, :board
  attr_reader :winner

  def initialize
    @players = []
    @rules = {}
    @players.extend PlayerCircle
  end

  def join(person, pawn)
    player = person.extend Player
    player.pawn = pawn
    player.game = self
    player.place_pawn_on_board

    @players.push player
  end

  def pawns
    players.map(&:pawn)
  end

  # method name suggestion from:
  # http://english.stackexchange.com/questions/117734
  def active_player
    @active_player ||= players.start
  end

  def next_turn
    @winner = active_player if active_player.pawn.location >= board.space_count
    @active_player = @players.next_after active_player
  end

  def play_round
    return if winner
    current_player = active_player

    round_finished = false
    until round_finished
      active_player.play_turn(die)

      round_finished = (active_player == current_player) || winner
    end
  end

  def set_rules_for_space(rules, space)
    @rules[space] = rules
  end

  def get_rules_for_space(space)
    @rules[space] || Rules::Base.new
  end
end
