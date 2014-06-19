require_relative './base'

module Rules
  # Brings the player to a new location
  class SkipTurn < Base
    def initialize(amount_turns_to_skip)
      @amount_turns_to_skip = amount_turns_to_skip
      @turns_skipped = 0
    end

    def allowed_to_roll?
      @turns_skipped += 1
      @turns_skipped > @amount_turns_to_skip
    end
  end
end
