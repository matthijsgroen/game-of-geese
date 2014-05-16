module Rules
  # Base class with
  # basic functionality
  # every rule can reuse
  class Base
    def initialize(player)
      @player = player
    end

    def enter_space(_pawn, _die)
    end

    def finish_turn?
      true
    end

    protected

    attr_reader :player
  end
end
