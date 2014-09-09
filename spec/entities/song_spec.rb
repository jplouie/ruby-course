require_relative '../spec_helper.rb'

describe Songify::Song do
  describe '#initialize' do
    it 'creates a song with a name and artist' do
      song = Songify::Song.new(name: 'Elevated', artist: 'The State Champs')
      expect(song).to be_a(Songify::Song)
      expect(song.name).to eq('Elevated')
      expect(song.artist).to eq('The State Champs')
    end
  end
end