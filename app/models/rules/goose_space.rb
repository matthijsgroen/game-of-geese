module Rules
  # When a player lands on this space,
  # he can move the amount of value of the dice again
  class GooseSpace < Base
    def enter_space(pawn, die)
      player.instance_eval do
        pawn.location += die.value
      end
    end
  end
end
