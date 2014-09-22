require 'pg'
require 'pry-byebug'

module Songify
  module Repos
    class ArtistsSongs
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songs-db')
      end

      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS artists_songs(
          id SERIAL PRIMARY KEY,
          artist_id INTEGER REFERENCES artists(id),
          song_id INTEGER REFERENCES songs(id)
        );
        SQL
        @db.exec(command)
      end

      def drop_table
        command = <<-SQL
        DROP TABLE IF EXISTS artists_songs;
        SQL
        @db.exec(command)
      end

      def add(song_id, artists)
        artists.each do |artist|
          command = <<-SQL
          INSERT INTO artists_songs(artist_id, song_id)
          VALUES ('#{artist.id}', '#{song_id}')
          SQL
          @db.exec(command)
        end
      end

      def delete(song_id)
        command = <<-SQL
        DELETE FROM artists_songs WHERE song_id = '#{song_id}';
        SQL
        @db.exec(command)
      end

      def get_artists(song_id)
        command = <<-SQL
        SELECT artist_id FROM artists_songs WHERE song_id = '#{song_id}';
        SQL
        result = @db.exec(command).entries
        result.map { |id_hash| Songify.artists_repo.get_artist(id_hash['artist_id'].to_i) }
      end
    end
  end
end