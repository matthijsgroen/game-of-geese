require 'spec_helper'
require 'support/roles/player'
require 'support/roles/board_pawn'

describe Game do
  let(:game) { Game.new }

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
      subject do
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
end
