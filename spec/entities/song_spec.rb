require_relative '../spec_helper.rb'

describe Songify::Song do
  describe '#initialize' do
    it 'creates a song with a name and artist' do
      genre = Songify::Genre.new(name: 'Alternative')
      lyrics = "So tell me why can't you see
        This is where you need to be?
        You know, it's taken its toll on me,
        But I don't feel invisible."
      song = Songify::Song.new(name: 'Elevated', artist: 'The State Champs', genre: genre, lyrics: lyrics)
      expect(song).to be_a(Songify::Song)
      expect(song.name).to eq('Elevated')
      expect(song.artist).to eq('The State Champs')
      expect(song.genre).to be_a(Songify::Genre)
      expect(song.lyrics).to include('invisible', 'taken')
    end
  end
end