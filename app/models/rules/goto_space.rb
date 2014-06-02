require_relative './base'

module Rules
  # Brings the player to a new location
  class GotoSpace < Base
    def initialize(destination)
      @destination = destination
    end

    def enter_space(pawn)
      local_destination = destination
      in_scope_of_player do
        respecting_rules do
          pawn.location = local_destination
        end
      end
    end

    private

    attr_reader :destination
  end
end
