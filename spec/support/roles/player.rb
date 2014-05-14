shared_examples_for 'a player' do

  it 'has a pawn to play' do
    expect(player.pawn).to eql pawn
  end

  describe '#move_pawn_using_dice' do
    let(:pawn) { double('pawn').extend(BoardPawn) }
    let(:dice) { FixedDice.new(6) }

    before do
      player.pawn = pawn
      pawn.location = 4
    end

    it 'moves the pawn forward using the outcome of the dice' do
      player.move_pawn_using_dice(dice)

      expect(player.pawn.location).to eql 10
    end
  end
end
