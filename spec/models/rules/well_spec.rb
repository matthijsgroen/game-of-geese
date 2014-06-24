require 'spec_helper'

describe Rules::Well do

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

  it 'moves the player when 6 is rolled' do
    game.set_rules_for_space described_class.new, 5

    # Arrive on space with well
    game.active_player.play_turn(die)

    game.active_player.play_turn(FixedDie.new 6)
    expect(pawn.location).to eql(11)
  end

  it 'locks the player for die values other than 6' do
    game.set_rules_for_space described_class.new, 5

    # Arrive on space with well
    game.active_player.play_turn(die)

    (1...5).each do |roll_value|
      game.active_player.play_turn(FixedDie.new roll_value)
      expect(pawn.location).to eql(5)
    end
  end
end
