require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do
  let(:song1) { Songify::Song.new(name: 'Elevated', artist: 'The State Champs') }
  let(:song2) { Songify::Song.new(name: 'Monkey Business', artist: 'Paramore') }
  before :all do
    @songs = Songify::Repos::Songs.new
  end

  before do
    Songify.songs_repo.drop_table
    Songify.songs_repo.create_table
  end

  describe 'can get and save songs' do
    it 'returns no songs if none are added' do
      result = @songs.get_songs
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it 'saves a song and gives it an id' do
      result = @songs.add(song1)
      expect(result).to be_a(Songify::Song)
      expect(result.id).to be_a(Fixnum)
      expect(result.name).to eq('Elevated')
    end

    it 'gets a song by its id' do
      @songs.add(song1)
      result = @songs.get_song(1)
      expect(result).to be_a(Songify::Song)
      expect(result.name).to eq('Elevated')
    end

    it 'returns an array of all stored songs' do
      @songs.add(song1)
      @songs.add(song2)
      result = @songs.get_songs
      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result[0].artist).to eq('The State Champs')
      expect(result[1].name).to eq('Monkey Business')
    end
  end

  describe '#delete' do
    it 'can delete songs' do
      song_with_id = @songs.add(song1)
      @songs.add(song2)
      @songs.delete(song_with_id)
      result = @songs.get_songs
      expect(result.length).to eq(1)
      expect(result[0].artist).to eq('Paramore')
    end
  end
end