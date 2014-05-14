shared_examples_for 'a player' do

  it 'has a pawn to play' do
    expect(player.pawn).to eql pawn
  end

  describe '#move_pawn_using_die' do
    let(:pawn) { double('pawn').extend(BoardPawn) }
    let(:die) { FixedDie.new(6) }

    before do
      player.pawn = pawn
      pawn.location = 4
    end

    it 'moves the pawn forward using the outcome of the die' do
      player.move_pawn_using_die(die)

      expect(player.pawn.location).to eql 10
    end
  end

  describe '#finish_turn' do
    it 'notifies the game that he/she is done with his/her turn' do
      expect(game).to receive(:next_turn)
      player.finish_turn
    end
  end

  describe '#play_turn' do
    let(:die) { double('die', roll: nil, value: 2) }

    subject { player.play_turn(die) }

    it 'rolls the die and moves the pawn' do
      expect(player).to receive(:move_pawn_using_die).with(die)
      subject
    end

    it 'ends the turn' do
      expect(player).to receive(:finish_turn)
      subject
    end
  end
end
