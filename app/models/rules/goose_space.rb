module Rules
  # When a player lands on this space,
  # he can move the amount of value of the dice again
  class GooseSpace < Base
    def enter_space(pawn)
      in_scope_of_player do
        pawn.location += die.value
      end
    end
  end
end
