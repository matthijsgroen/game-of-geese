require 'spec_helper'

describe Person do
  describe 'attributes' do
    it 'has a name' do
      p = Person.new name: 'Henk'
      expect(p.name).to eql 'Henk'
    end

    it 'has an age' do
      p = Person.new age: 34
      expect(p.age).to eql 34
    end
  end
end
