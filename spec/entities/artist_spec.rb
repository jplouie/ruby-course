require_relative '../spec_helper.rb'

describe Songify::Artist do
  describe '#initialize' do
    it 'creates an artist with a name' do
      artist = Songify::Artist.new(name: 'Anberlin')
      expect(artist).to be_a(Songify::Artist)
      expect(artist.name).to eq('Anberlin')
    end
  end
end