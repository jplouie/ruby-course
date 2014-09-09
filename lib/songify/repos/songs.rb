require 'pg'

module Songify
  module Repos
    class Songs
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songs-db')
      end

      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS songs(
          id SERIAL PRIMARY KEY,
          name TEXT,
          artist TEXT
        );
        SQL
        @db.exec(command)
      end

      def drop_table
        command = <<-SQL
        DROP TABLE IF EXISTS songs;
        SQL
        @db.exec(command)
      end

      def add(song)
        command = <<-SQL
        INSERT INTO songs(name, artist)
        VALUES ('#{song.name}', '#{song.artist}')
        RETURNING *;
        SQL
        result = @db.exec(command).first
        build_song(result)
      end

      def get_songs
        command = <<-SQL
        SELECT * FROM songs;
        SQL
        result = @db.exec(command).entries
        result.map { |row| build_song(row) }
      end

      def get_song(song_id)
        command = <<-SQL
        SELECT * FROM songs WHERE id = '#{song_id}';
        SQL
        result = @db.exec(command).first
        build_song(result)
      end

      def delete(song)
        command = <<-SQL
        DELETE FROM songs WHERE id = '#{song.id}';
        SQL
        @db.exec(command)
      end

      def build_song(row)
        Songify::Song.new(
          name: row['name'],
          artist: row['artist'],
          id: row['id'].to_i
        )
      end
    end
  end
end