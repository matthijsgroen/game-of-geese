require 'cucumber/formatter/pretty'
require 'drb/drb'

module Cucumber
  module Formatter
    # Creates a layout on screen to show the cucumber steps
    # and the active state of the game
    class Demo < Pretty
      class << self
        attr_accessor :active
        attr_accessor :instance

        def update_game(game)
          @game = game
          add_game_hooks(game)
          send_game_struct_to_view
        end

        def update
          send_game_struct_to_view
        end

        private

        attr_reader :game

        # tell gosu when die is rolled
        module DieListener
          attr_accessor :formatter_listener

          def roll
            super.tap { formatter_listener.update }
          end
        end

        # tell gosu when pawn is moved
        module PawnListener
          attr_accessor :formatter_listener

          def location=(_value)
            super.tap { formatter_listener.update }
          end
        end

        def add_game_hooks(game)
          return unless game
          add_listener(game.die, DieListener)
          game.players.each do |p|
            add_listener(p.pawn, PawnListener)
          end
        end

        def add_listener(obj, listener)
          return unless obj
          obj_modules = (class << obj; self; end).included_modules
          return if obj_modules.include? listener
          obj.extend listener
          obj.formatter_listener = self
        end

        def send_game_struct_to_view
          game_struct = create_game_struct(game)
          with_remote_game do |remote|
            remote.game_struct = game_struct
          end
          sleep 0.5
        end

        def with_remote_game
          @remotegame ||= DRbObject.new_with_uri('druby://localhost:8787')
          yield @remotegame
        rescue DRb::DRbConnError
          # Our client is not started!
          spawn 'ruby lib/gosu-formatter/remote_client.rb'
          sleep 1
          retry
        end

        def create_game_struct(game)
          return {} unless game
          {
            board: {
              space_count: game.board.space_count
            },
            die_value: game.die.value,
            players: create_players_struct(game.players,
                                           game.active_player, game.winner)
          }
        end

        def create_players_struct(players, active_player, winner)
          players.map do |p|
            {
              name: p.name,
              age: p.age,
              active: p == active_player,
              winner: p == winner,
              pawn: create_pawn_struct(p.pawn)
            }
          end
        end

        def create_pawn_struct(pawn)
          {
            color: pawn.color,
            location: pawn.location
          }
        end
      end

      def initialize(*)
        self.class.active = true
        self.class.instance ||= self
        super
      end
    end
  end
end
