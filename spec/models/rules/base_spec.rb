require 'spec_helper'

describe Rules::Base do

  describe '#apply_to' do
    let(:player) { double('player') }

    it 'makes a duplicate with an assigned player' do
      inst1 = described_class.new
      inst2 = inst1.apply_to(player)

      expect(inst1.player).to be_nil
      expect(inst2.player).to eql player
      expect(inst2).to be_a described_class
    end
  end
end
