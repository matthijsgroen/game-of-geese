shared_examples_for 'a player' do

  it 'has a pawn to play' do
    expect(subject.pawn).to eql pawn
  end

end
