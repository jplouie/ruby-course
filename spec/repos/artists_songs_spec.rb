require_relative '../spec_helper.rb'

describe Songify::Repos::ArtistsSongs do
  let(:genre1) { Songify::Genre.new(name: 'Rock') }
  let(:artist1) { Songify::Artist.new(name: 'Artist1') }
  let(:artist2) { Songify::Artist.new(name: 'Artist2') }

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

  describe 'it adds artist ids and song id pairs' do
    it 'adds any number of artists to a song' do
      genre_with_id = Songify.genres_repo.add(genre1)
      artist_with_id1 = Songify.artists_repo.add(artist1)
      artist_with_id2 = Songify.artists_repo.add(artist2)
      song = Songify::Song.new(name: 'Blah', artist: [artist_with_id2, artist_with_id1], genre: genre_with_id, lyrics: 'hello world')
      song_with_id = Songify.songs_repo.add(song)
      result = Songify.artists_songs_repo.get_artists(song_with_id.id)
      expect(result.length).to eq(2)
      expect(result.first).to be_a(Songify::Artist)
    end
  end
end