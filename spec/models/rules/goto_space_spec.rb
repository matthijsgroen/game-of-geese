require 'spec_helper'

describe Rules::GotoSpace do

  let(:game) { Game.new }
  let(:board) { Board.new 40 }
  let(:die) { FixedDie.new 5 }

  let(:pawn) { Pawn.new color: :blue }
  let(:person) { Person.new age: 8 }

  before do
    game.board = board
    game.die = die

    game.join person, pawn
  end

  it 'brings the player to a new location' do
    game.set_rules_for_space described_class.new(18), 5
    game.play_round
    expect(pawn.location).to eql 18
  end

end
