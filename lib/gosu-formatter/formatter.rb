require 'cucumber/formatter/pretty'
require 'drb/drb'
require_relative './listeners/die_listener'
require_relative './listeners/pawn_listener'

module Cucumber
  module Formatter
    # Creates a layout on screen to show the cucumber steps
    # and the active state of the game
    class Demo < Pretty
      class << self
        attr_accessor :active
        attr_accessor :instance

        def initialize
          super
          FixedDie.extend DieListener
          FixedDie.formatter_listener = self
        end

        def update_game(game)
          @game = game
          add_game_hooks(game)
          struct = create_game_struct(game)
          send_game_struct_to_view(struct)
        end

        def update
          struct = create_game_struct(game)
          send_game_struct_to_view(struct)
          sleep 1.0
        end

        def roll(value)
          struct = create_game_struct(game)
          struct[:die] = { rolling: true, value: value }
          send_game_struct_to_view(struct)
          sleep 1.0
        end

        private

        attr_reader :game

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

        def send_game_struct_to_view(game_struct)
          with_remote_game do |remote|
            remote.game_struct = game_struct
          end
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
            rules: create_rules_struct(game),
            die: { value: game.die.value, rolling: false },
            players: create_players_struct(game.players,
                                           game.active_player, game.winner)
          }
        end

        def create_rules_struct(game)
          rules = {}
          game.board.space_count.times do |index|
            rule = game.get_rules_for_space(index)
            next unless rule && rule.class != Rules::Base
            rules[index] = {
              rule: rule.class.name
            }
          end
          rules
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
