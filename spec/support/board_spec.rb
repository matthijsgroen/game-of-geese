require 'spec_helper'

describe Board do

  let(:spaces) { 30 }
  let(:board) { Board.new spaces }

  describe '#spaces' do
    it 'returns the amount of spaces on the board' do
      expect(board.spaces).to eql spaces
    end
  end
end
