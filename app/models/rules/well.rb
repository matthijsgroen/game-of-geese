require_relative './base'

module Rules
  # It locks the player in place
  class Well < Base
    def leave_space(pawn, die_value)
      pawn.location += die_value if die_value == 6
    end
  end
end
