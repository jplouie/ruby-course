module Songify
  def self.songs_repo=(repo)
    @songs_repo = repo
  end

  def self.songs_repo
    @songs_repo
  end

  def self.genres_repo=(repo)
    @genres_repo = repo
  end

  def self.genres_repo
    @genres_repo
  end

  def self.artists_repo=(repo)
    @artists_repo = repo
  end

  def self.artists_repo
    @artists_repo
  end

  module Repos
    def self.create_tables
      Songify.songs_repo.create_table
      Songify.genres_repo.create_table
      Songify.artists_repo.create_table
    end

    def self.drop_tables
      Songify.songs_repo.drop_table
      Songify.genres_repo.drop_table
      Songify.artists_repo.drop_table
    end
  end
end

require_relative './songify/entities/song.rb'
require_relative './songify/entities/genre.rb'
require_relative './songify/entities/artist.rb'
require_relative './songify/repos/songs.rb'
require_relative './songify/repos/genres.rb'
require_relative './songify/repos/artists.rb'

Songify.songs_repo = Songify::Repos::Songs.new
Songify.genres_repo = Songify::Repos::Genres.new
Songify.artists_repo = Songify::Repos::Artists.new