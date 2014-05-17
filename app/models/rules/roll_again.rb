module Rules
  # Allows the player to roll again
  class RollAgain < Base
    attr_accessor :max_die_value

    def finish_turn?(die)
      return false unless max_die_value
      die.value > max_die_value
    end
  end
end
