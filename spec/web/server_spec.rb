require 'server_spec_helper'

describe Songify::Server do
  def app
    Songify::Server.new
  end

  let(:song1) { Songify::Song.new(name: 'Elevated', artist: 'The State Champs') }
  let(:song2) { Songify::Song.new(name: 'Misery Business', artist: 'Paramore') }
  let(:song3) { Songify::Song.new(name: 'Ocean Avenue', artist: 'Yellowcard')}

  before do
    Songify.songs_repo.drop_table
    Songify.songs_repo.create_table
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
      expect(last_response.body).to include('Ocean Avenue', 'Yellowcard')
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
      post '/songs', { name: 'In the End', artist: 'Linkin Park' }
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
    it 'edits the name of the song and/or artist' do
      song = Songify.songs_repo.add(song2)

      put "/songs/#{song.id}"
      expect(last_response).to be_redirect
    end
  end
end