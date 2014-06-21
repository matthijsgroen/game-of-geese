# The role of a person playing game of goose
module Player
  attr_accessor :pawn
  attr_accessor :game

  def place_pawn_on_board
    pawn.extend BoardPawn
    respecting_rules do
      pawn.location = 0
    end
  end

  def play_turn(die)
    @die = die

    respecting_rules do
      move_pawn_using_die
    end
    finish_turn

    @die = nil
  end

  def allowed_to_play?
    active_rule.allowed_to_roll?
  end

  private

  attr_reader :active_rule, :die

  def move_pawn_using_die
    die.roll
    active_rule.leave_space(pawn, die.value)
  end

  def finish_turn
    return unless active_rule.finish_turn?
    game.next_turn
  end

  def respecting_rules
    yield

    rules = game.get_rules_for_space(pawn.location)
    @active_rule = rules.apply_to(self)
    @active_rule.enter_space(pawn)
  end
end
