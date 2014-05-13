require 'spec_helper'

describe Game do
  describe '#join' do
    let(:game) { Game.new }
    let(:person) { double('person') }
    let(:pawn) { double('pawn') }

    subject { game.join(person, pawn) }

    it 'lists the person in the list of players' do
      subject
      expect(game.players).to include person
    end
  end
end
