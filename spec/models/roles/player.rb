shared_examples_for 'a player' do

  it 'has a pawn to play' do
    expect(player.pawn).to eql pawn
  end

  describe '#play_turn' do
    let(:pawn) { double('pawn').extend(BoardPawn) }
    let(:die) { double('die', roll: nil, value: 6) }

    subject { player.play_turn(die) }

    before do
      player.pawn = pawn
      pawn.location = 4
    end

    it 'moves the pawn forward using the outcome of the die' do
      subject

      expect(player.pawn.location).to eql 10
    end

    it 'ends the turn' do
      expect(game).to receive(:next_turn)
      subject
    end
  end
end
