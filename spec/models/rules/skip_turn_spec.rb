require 'spec_helper'

describe Rules::SkipTurn do

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

  it 'lets skip a number of turns' do
    game.set_rules_for_space described_class.new(1), 5

    # Arrive on space with skip turn
    game.active_player.play_turn(die)
    expect(game.active_player).to eql(other_person)

    # Other player moves
    game.active_player.play_turn(FixedDie.new 8)

    # Player is not allowed to roll and move
    expect(game.die).not_to receive(:roll)
    expect do
      game.active_player.play_turn(die)
    end.not_to change { pawn.location }

    expect(game.active_player).to eql(other_person)
  end

end
