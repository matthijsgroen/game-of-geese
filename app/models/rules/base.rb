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

    def enter_space(_pawn)
    end

    def finish_turn?
      true
    end

    def allowed_to_roll?
      true
    end

    attr_accessor :player

    protected

    def in_scope_of_player(&block)
      player.instance_eval(&block)
    end
  end
end
