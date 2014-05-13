shared_examples_for 'a board pawn' do

  it 'has a location on the board' do
    expect(subject.location).to eql 0
  end
end
