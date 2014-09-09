module Songify
  def self.songs_repo=(repo)
    @songs_repo = repo
  end

  def self.songs_repo
    @songs_repo
  end
  module Repos
    def self.create_tables
      Songify.songs_repo.create_table
    end

    def self.drop_tables
      Songify.songs_repo.drop_table
    end
  end
end

require_relative './songify/entities/song.rb'
require_relative './songify/repos/songs.rb'

Songify.songs_repo = Songify::Repos::Songs.new