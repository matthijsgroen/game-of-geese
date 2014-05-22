require 'spec_helper'

describe Board do

  let(:space_count) { 30 }
  let(:board) { Board.new space_count }

  describe '#spaces' do
    it 'returns the amount of spaces on the board' do
      expect(board.space_count).to eql space_count
    end
  end

  describe '#set_label_for_space' do
    it 'attaches a label to a space' do
      board.set_label_for_space('Lorem Ipsum', 5)
      expect(board.label_for_space(5)).to eql 'Lorem Ipsum'
    end
  end

end
