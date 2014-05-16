module Rules
  # Allows the player to roll again
  class RollAgain < Base
    def finish_turn?
      false
    end
  end
end
