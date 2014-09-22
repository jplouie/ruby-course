require_relative '../spec_helper.rb'

describe Songify::Repos::Songs do
  let(:genre1) { @genres.add(Songify::Genre.new(name: 'Rock')) }
  let(:genre2) { @genres.add(Songify::Genre.new(name: 'Alternative')) }
  let(:genre3) { @genres.add(Songify::Genre.new(name: 'Pop')) }
  let(:artist1) { @artists.add(Songify::Artist.new(name: 'The State Champs')) }
  let(:artist2) { @artists.add(Songify::Artist.new(name: 'Paramore')) }
  let(:lyrics1) { "So tell me why can't you see
    This is where you need to be?
    You know, it's taken its toll on me,
    But I don't feel invisible." }
  let(:lyrics2) { "And if you could then you know you would.
    'Cause God it just feels so...
    It just feels so good." }
  let(:song1) { Songify::Song.new(name: 'Elevated', artist: [artist1], genre: genre2, lyrics: lyrics1) }
  let(:song2) { Songify::Song.new(name: 'Misery Business', artist: [artist2], genre: genre2, lyrics: lyrics2) }

  before :all do
    @songs = Songify::Repos::Songs.new
    @genres = Songify::Repos::Genres.new
    @artists = Songify::Repos::Artists.new
  end

  before do
    Songify.artists_songs_repo.drop_table
    Songify.artists_repo.drop_table
    Songify.songs_repo.drop_table
    Songify.genres_repo.drop_table
    Songify.genres_repo.create_table
    Songify.artists_repo.create_table
    Songify.songs_repo.create_table
    Songify.artists_songs_repo.create_table
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
      expect(result.genre.name).to eq('Alternative')
    end

    it 'returns an array of all stored songs' do
      @songs.add(song1)
      @songs.add(song2)
      result = @songs.get_songs
      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result[0].artist.first.name).to eq('The State Champs')
      expect(result[1].name).to eq('Misery Business')
    end
  end

  describe '#delete' do
    it 'can delete songs' do
      song_with_id = @songs.add(song1)
      @songs.add(song2)
      @songs.delete(song_with_id)
      result = @songs.get_songs
      expect(result.length).to eq(1)
      expect(result[0].artist.first.name).to eq('Paramore')
    end
  end

  describe '#search' do
    it 'can search for songs based on lyrics' do
      @songs.add(song1)
      @songs.add(song2)
      result = @songs.search('you')
      expect(result.length).to eq(2)
      expect(result[1]).to be_a(Songify::Song)
    end
  end
end