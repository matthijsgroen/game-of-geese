require 'spec_helper'

describe Rules::Curvet do

  let(:game) { Game.new }
  let(:board) { Board.new 40 }
  let(:die) { FixedDie.new 5 }

  let(:pawn) { Pawn.new color: :blue }
  let(:person) { Person.new age: 8 }
  let(:first_person) { Person.new age: 9 }
  let(:first_pawn) { Pawn.new color: :red }

  before do
    game.board = board
    game.die = die

    game.join person, pawn
    game.join first_person, first_pawn
  end

  it 'moves the pawn one space before the first pawn' do
    first_pawn.location = 13
    rule = described_class.new
    game.set_rules_for_space rule, 5

    expect do
      game.active_player.play_turn(die)
    end.to change { pawn.location }.to 14
  end

  it 'does not move the pawn when first pawn' do
    first_pawn.location = 2
    rule = described_class.new
    game.set_rules_for_space rule, 5

    expect do
      game.active_player.play_turn(die)
    end.to change { pawn.location }.to 5
  end

end
