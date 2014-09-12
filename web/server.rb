require_relative '../lib/songify.rb'
require 'sinatra/base'


class Songify::Server < Sinatra::Application
  configure do
    set :bind, '0.0.0.0'
  end

  get '/songs' do
    @songs = Songify.songs_repo.get_songs
    erb :index
  end

  get '/songs/new' do
    @genres = Songify.genres_repo.get_genres
    erb :info
  end

  get '/songs/search' do
    erb :search
  end

  get '/songs/search/results' do
    @songs = Songify.songs_repo.search(params[:search])
    erb :search_results
  end

  get '/songs/:id' do
    @song = Songify.songs_repo.get_song(params[:id])
    erb :show
  end

  get '/songs/:id/edit' do
    @song = Songify.songs_repo.get_song(params[:id])
    @genres = Songify.genres_repo.get_genres
    erb :edit
  end

  put '/songs/:id' do
    genre = Songify.genres_repo.get_genre_by_name(params[:genre])
    Songify.songs_repo.edit_song(params[:id], params[:name], params[:artist], genre.id, lyrics: params[:lyrics])
    redirect to("/songs/#{params[:id]}")
  end

  post '/songs' do
    genre = Songify::genres_repo.get_genre_by_name(params[:genre])
    song = Songify::Song.new(name: params[:name], artist: params[:artist], genre: genre, lyrics: params[:lyrics])
    song_with_id = Songify.songs_repo.add(song)
    redirect to("/songs/#{song_with_id.id}")
  end

  get '/genres' do
    @genres = Songify.genres_repo.get_genres
    erb :genres_index
  end

  get '/genres/new' do
    erb :genres_info
  end

  get '/genres/:id' do
    @genre = Songify.genres_repo.get_genre(params[:id])
    erb :genre_show
  end

  post '/genres' do
    genre = Songify.genres_repo.add(Songify::Genre.new(name: params[:name]))
    redirect to("/genres/#{genre.id}")
  end
end