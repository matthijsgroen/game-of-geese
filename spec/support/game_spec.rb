require 'spec_helper'
require 'support/roles/player'
require 'support/roles/board_pawn'

describe Game do
  let(:game) { Game.new }

  before do
    game.board = double('board', spaces: 50)
  end

  describe '#join' do
    let(:person) { double('person') }
    let(:pawn) { double('pawn') }

    let(:join) { game.join(person, pawn) }
    subject { join }

    it 'lists the person in the list of players' do
      subject
      expect(game.players).to match_array [person]
    end

    describe 'the joined person' do
      let(:player) do
        join
        game.players.first
      end

      it_should_behave_like 'a player'
    end

    describe 'the joined pawn' do
      subject do
        join
        game.pawns.first
      end

      it_should_behave_like 'a board pawn'
    end
  end

  describe '#active_player' do
    subject { game.active_player }

    context 'with nobody playing' do
      it 'is nobody' do
        expect(subject).to be_nil
      end
    end

    context 'with one player' do
      let(:person) { double('person') }
      before do
        game.join(person, double('pawn'))
      end

      it 'the only player joined' do
        expect(subject).to eql person
      end
    end

    context 'with multiple players' do
      let(:older_person) { double('older person', age: 15) }
      let(:young_person) { double('young person', age: 9) }

      before do
        game.join(older_person, double('pawn'))
        game.join(young_person, double('pawn'))
      end

      it 'is the youngest player' do
        expect(subject).to eql young_person
      end
    end
  end

  describe 'die attribute' do
    let(:die) { double('die') }
    it 'can have a die' do
      game.die = die
      expect(game.die).to eql die
    end
  end

  describe '#play_round' do
    subject { game.play_round }

    let(:young_person)  { double('young person',  age: 9)  }
    let(:middle_person) { double('middle person', age: 11) }
    let(:older_person)  { double('older person',  age: 15) }
    let(:die) { double('die') }

    before do
      game.join(middle_person, double('pawn'))
      game.join(young_person,  double('pawn'))
      game.join(older_person,  double('pawn'))
      game.die = die
    end

    it 'lets each player play a turn offering a die' do
      expect(young_person).to receive(:play_turn).with(die).ordered do
        game.next_turn
      end
      expect(older_person).to receive(:play_turn).with(die).ordered do
        game.next_turn
      end
      expect(middle_person).to receive(:play_turn).with(die).ordered do
        game.next_turn
      end

      subject
    end
  end

  describe '#winner' do
    it 'is undetermined by default' do
      expect(game.winner).to be_nil
    end

    describe 'assignment' do
      let(:young_person) { double('young person', age: 7) }
      let(:older_person) { double('older person', age: 8) }
      let(:pawn1) { double('pawn') }
      let(:pawn2) { double('pawn') }

      before do
        game.board = Board.new(40)
        game.die = double('die', roll: nil, value: 5)
        game.join(young_person, pawn1)
        pawn1.location = game.board.spaces - 1

        game.join(older_person, pawn2)
        pawn2.location = game.board.spaces - 1
      end

      it 'is done when a player reaches the end of the board' do
        expect do
          game.play_round
        end.to change { game.winner }.from(nil).to(young_person)
      end
    end
  end

  describe 'adding game rules to spaces' do

    it 'allows for setting and getting rules' do
      rule = double('rule')
      game.set_rules_for_space(rule, 5)
      expect(game.get_rules_for_space(5)).to eql rule
    end

  end
end
