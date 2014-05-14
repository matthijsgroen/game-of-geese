# The role of a person playing game of goose
module Player
  attr_accessor :pawn
  attr_accessor :game

  def move_pawn_using_dice(dice)
    dice.roll
    pawn.location += dice.value
  end

  def finish_turn
    game.next_turn
  end
end
