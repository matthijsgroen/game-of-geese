# The role of a person playing game of goose
module Player
  attr_accessor :pawn
  attr_accessor :game

  def play_turn(die)
    respecting_rules(die) do
      move_pawn_using_die(die)
    end
    finish_turn
  end

  private

  attr_reader :active_rule

  def move_pawn_using_die(die)
    die.roll
    pawn.location += die.value
  end

  def finish_turn
    return if active_rule && !active_rule.finish_turn?
    game.next_turn
  end

  def respecting_rules(die)
    yield
    rules = game.get_rules_for_space(pawn.location)
    if rules
      @active_rule = rules.apply_to(self)
      @active_rule.enter_space(pawn, die)
    end
  end
end
