require 'spec_helper'
require 'support/roles/player'
require 'support/roles/pawn'

describe Game do
  describe '#join' do
    let(:game) { Game.new }
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

      it_should_behave_like 'a pawn'
    end
  end
end
