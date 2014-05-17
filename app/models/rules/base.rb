module Rules
  # Base class with
  # basic functionality
  # every rule can reuse
  class Base
    def apply_to(player)
      applied_rule = dup
      applied_rule.player = player
      applied_rule
    end

    def enter_space(_pawn, _die)
    end

    def finish_turn?(_die)
      true
    end

    attr_accessor :player
  end
end
