require 'pg'
require 'pry-byebug'

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
          genre INTEGER REFERENCES genres(id),
          lyrics TEXT
        );
        SQL
        @db.exec(command)
      end

      def drop_table
        command = <<-SQL
        DROP TABLE IF EXISTS songs CASCADE;
        SQL
        @db.exec(command)
      end

      def add(song)
        edited_lyrics = song.lyrics.gsub("'", "''")
        command = <<-SQL
        INSERT INTO songs(name, genre, lyrics)
        VALUES ('#{song.name}', '#{song.genre.id}', '#{edited_lyrics}')
        RETURNING *;
        SQL
        result = @db.exec(command).first

        Songify.artists_songs_repo.add(result['id'].to_i, song.artist)
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

      def get_song_id(song_name)
        command = <<-SQL
        SELECT * FROM songs WHERE name = '#{song_name}';
        SQL
        @db.exec(command).first['id'].to_i
      end

      def edit_song(song_id, new_name, new_artist, new_genre, new_lyrics)
        edited_lyrics = new_lyrics[:lyrics].gsub("'", "''")
        command = <<-SQL
        UPDATE songs
        SET name = '#{new_name}', genre = '#{new_genre}', lyrics = '#{edited_lyrics}'
        WHERE id = '#{song_id}'
        RETURNING *;
        SQL
        Songify.artists_songs_repo.delete(song_id)
        Songify.artists_songs_repo.add(song_id, new_artist)

        result = @db.exec(command).first
        build_song(result)
      end

      def delete(song)
        Songify.artists_songs_repo.delete(song)
        command = <<-SQL
        DELETE FROM songs WHERE id = '#{song.id}';
        SQL
        @db.exec(command)
      end

      def search(search_lyrics)
        command = <<-SQL
        SELECT * FROM songs WHERE lyrics ~* '#{search_lyrics}';
        SQL
        result = @db.exec(command).entries
        result.map { |row| build_song(row) }
      end

      def build_song(row)
        genre = Songify.genres_repo.get_genre(row['genre'].to_i)
        artists = Songify.artists_songs_repo.get_artists(row['id'].to_i)
        lyrics = row['lyrics'].gsub("''", "'")

        Songify::Song.new(
          name: row['name'],
          artist: artists,
          id: row['id'].to_i,
          genre: genre,
          lyrics: lyrics
        )
      end
    end
  end
end