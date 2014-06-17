require 'spec_helper'

describe Rules::SkipTurn do

  let(:game) { Game.new }
  let(:board) { Board.new 40 }
  let(:die) { FixedDie.new 5 }

  let(:pawn) { Pawn.new color: :blue }
  let(:person) { Person.new age: 8 }
  let(:second_person) { Person.new age: 9 }
  let(:third_person) { Person.new age: 10 }

  before do
    game.board = board
    game.die = die

    game.join person, pawn
    game.join second_person, Pawn.new(color: :red)
    game.join third_person, Pawn.new(color: :white)
  end

  it 'lets a player skip a number of turns' do
    game.set_rules_for_space described_class.new(1), 5

    # Arrive on space with skip turn
    game.active_player.play_turn(die)

    expect(game.active_player).to eql(second_person)
    game.active_player.play_turn(FixedDie.new 8)
    expect(game.active_player).to eql(third_person)

    # Other player moves
    expect do
      game.active_player.play_turn(FixedDie.new 8)
    end.to change { game.active_player }.to(second_person)
  end

end
