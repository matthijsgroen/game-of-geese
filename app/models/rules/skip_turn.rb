require_relative './base'

module Rules
  # Brings the player to a new location
  class SkipTurn < Base
    def initialize(_amount_turns_to_skip)
    end

    def allowed_to_roll?
      false
    end

    # def enter_space(pawn)
    #   local_destination = destination
    #   in_scope_of_player do
    #     respecting_rules do
    #       pawn.location = local_destination
    #     end
    #   end
    # end
  end
end
