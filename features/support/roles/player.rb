# The role of a person playing game of goose
module Player
  attr_accessor :pawn

  def move_pawn_using_dice(dice)
    dice.roll
    pawn.location += dice.value
  end
end
