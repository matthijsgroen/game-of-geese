require 'spec_helper'

describe Rules::RollAgain do

  let(:game) { Game.new }
  let(:board) { Board.new 40 }
  let(:die) { FixedDie.new 5 }

  let(:pawn) { Pawn.new color: :blue }
  let(:person) { Person.new age: 8 }
  let(:other_person) { Person.new age: 9 }

  before do
    game.board = board
    game.die = die

    game.join person, pawn
    game.join other_person, Pawn.new(color: :red)
  end

  it 'lets the player roll again' do
    game.set_rules_for_space described_class.new, 5
    expect do
      game.active_player.play_turn(die)
    end.not_to change { game.active_player }
  end
end
