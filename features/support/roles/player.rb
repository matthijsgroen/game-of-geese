# The role of a person playing game of goose
module Player
  attr_accessor :pawn
  attr_accessor :game

  def move_pawn_using_die(die)
    die.roll
    pawn.location += die.value
  end

  def finish_turn
    game.next_turn
  end

  def play_turn(die)
    move_pawn_using_die(die)
    finish_turn
  end
end
