require_relative '../spec_helper.rb'

describe Songify::Genre do
  describe '#initialize' do
    it 'creates a genre with a name' do
      pop = Songify::Genre.new(name: 'pop')
      expect(pop).to be_a(Songify::Genre)
      expect(pop.name).to eq('pop')
    end
  end
end