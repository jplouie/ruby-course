require 'server_spec_helper'

describe Songify::Server do
  def app
    Songify::Server.new
  end

  let(:genre1) { Songify.genres_repo.get_genre_by_name('Rock') }
  let(:genre2) { Songify.genres_repo.get_genre_by_name('Alternative') }
  let(:genre3) { Songify.genres_repo.get_genre_by_name('Pop') }
  let(:lyrics1) { "So tell me why can't you see
    This is where you need to be?
    You know, it's taken its toll on me,
    But I don't feel invisible." }
  let(:lyrics2) { "And if you could then you know you would.
    'Cause God it just feels so...
    It just feels so good." }
  let(:lyrics3) { "There's this place on Ocean Avenue" }
  let(:song1) { Songify::Song.new(name: 'Elevated', artist: 'The State Champs', genre: genre2, lyrics: lyrics1) }
  let(:song2) { Songify::Song.new(name: 'Misery Business', artist: 'Paramore', genre: genre2, lyrics: lyrics2) }
  let(:song3) { Songify::Song.new(name: 'Ocean Avenue', artist: 'Yellowcard', genre: genre1, lyrics: lyrics3)}

  before do
    Songify.songs_repo.drop_table
    Songify.genres_repo.drop_table
    Songify.genres_repo.create_table
    Songify.songs_repo.create_table
    Songify.genres_repo.add(Songify::Genre.new(name: 'Rock'))
    Songify.genres_repo.add(Songify::Genre.new(name: 'Alternative'))
    Songify.genres_repo.add(Songify::Genre.new(name: 'Pop'))
  end


  describe 'get /songs' do
    it 'loads the homepage' do
      Songify.songs_repo.add(song1)
      Songify.songs_repo.add(song2)
      Songify.songs_repo.add(song3)

      get '/songs'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Yellowcard', 'Misery Business')
    end
  end

  describe 'get /songs/:id' do
    it 'shows the requested song' do
      song = Songify.songs_repo.add(song3)

      get "/songs/#{song.id}"
      expect(last_response).to be_ok
      expect(last_response.body).to include('Ocean Avenue', 'Yellowcard', 'place')
    end
  end

  describe 'get /songs/new' do
    it 'shows the form to create a new song' do
      get '/songs/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include('name', 'artist')
    end
  end

  describe 'post /songs' do
    it 'creates the song from user input' do
      post '/songs', { name: 'In the End', artist: 'Linkin Park', genre: 'Rock', lyrics: 'In the end I got so far' }
      expect(last_response).to be_redirect
    end
  end

  describe 'get /songs/:id/edit' do
    it 'displays a form to edit the song fields' do
      song = Songify.songs_repo.add(song2)

      get "/songs/#{song.id}/edit"
      expect(last_response).to be_ok
      expect(last_response.body).to include('Edit')
    end
  end

  describe 'put /songs/:id' do
    it 'edits the name of the song, artist, and/or genre' do
      song = Songify.songs_repo.add(song2)

      put "/songs/#{song.id}", { id: song.id, name: song.name, artist: song.artist, genre: song.genre.name, lyrics: song.lyrics }
      expect(last_response).to be_redirect
    end
  end

  describe 'get /genres' do
    it 'displays all genres' do
      get '/genres'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Rock", "Alternative", "Pop")
    end
  end

  describe 'get /genres/new' do
    it 'shows the form to add a genre' do
      get '/genres/new'
      expect(last_response).to be_ok
      expect(last_response.body).to include('name')
    end
  end

  describe 'get /genres/:id' do
    it 'gets the specified genre' do
      genre = Songify.genres_repo.get_genre_by_name("Rock")

      get "/genres/#{genre.id}"
      expect(last_response).to be_ok
      expect(last_response.body).to include('Rock')
    end
  end

  describe 'post /genres' do
    it 'creates a genre from user input' do
      post '/genres', { name: 'Rap' }
      expect(last_response).to be_redirect
    end
  end
end