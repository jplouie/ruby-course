require_relative '../spec_helper.rb'

describe Songify::Song do
  describe '#initialize' do
    it 'creates a song with a name and artist' do
      genre = Songify::Genre.new(name: 'Alternative')
      song = Songify::Song.new(name: 'Elevated', artist: 'The State Champs', genre: genre)
      expect(song).to be_a(Songify::Song)
      expect(song.name).to eq('Elevated')
      expect(song.artist).to eq('The State Champs')
      expect(song.genre).to be_a(Songify::Genre)
    end
  end
end