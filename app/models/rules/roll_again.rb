module Rules
  # Allows the player to roll again
  class RollAgain < Base
    attr_accessor :max_die_value

    def finish_turn?
      return false unless max_die_value
      die_value = in_scope_of_player { die.value }
      die_value > max_die_value
    end
  end
end
