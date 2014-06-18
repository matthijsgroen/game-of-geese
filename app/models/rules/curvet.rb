require_relative './base'

module Rules
  # When a player lands on this space,
  # he can move one space before the first pawn on the board
  class Curvet < Base
    def enter_space(pawn)
      in_scope_of_player do
        sorted_pawns = game.pawns.sort { |a, b| b.location <=> a.location }
        target_pawn = sorted_pawns.index(pawn) - 1

        return unless target_pawn >= 0

        respecting_rules do
          pawn.location = sorted_pawns[target_pawn].location + 1
        end
      end
    end
  end
end
