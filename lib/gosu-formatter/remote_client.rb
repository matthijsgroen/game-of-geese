require_relative '../../app/models/board'
require_relative '../../app/models/die'
require_relative '../../app/models/game'
require_relative '../../app/models/pawn'
require_relative '../../app/models/person'
require_relative '../../app/models/roles/player_circle'
require_relative '../../app/models/roles/player'
require_relative './game_window'

require 'drb/drb'

window = GameWindow.new
DRb.start_service('druby://localhost:8787', window)
window.show
