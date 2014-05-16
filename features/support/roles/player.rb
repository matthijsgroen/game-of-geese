# The role of a person playing game of goose
module Player
  attr_accessor :pawn
  attr_accessor :game

  def play_turn(die)
    respecting_rules do
      move_pawn_using_die(die)
    end
    finish_turn
  end

  private

  def move_pawn_using_die(die)
    die.roll
    pawn.location += die.value
  end

  def finish_turn
    game.next_turn
  end

  def respecting_rules
    yield
  end
end
