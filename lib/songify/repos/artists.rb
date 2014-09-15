require 'pg'
require 'pry-byebug'

module Songify
  module Repos
    class Artists
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songs-db')
      end

      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS artists(
          id SERIAL PRIMARY KEY,
          name TEXT
          );
        SQL
        @db.exec(command)
      end

      def drop_table
        command = <<-SQL
        DROP TABLE IF EXISTS artists CASCADE;
        SQL
        @db.exec(command)
      end

      def add(artist)
        command = <<-SQL
        INSERT INTO artists(name)
        VALUES ('#{artist.name}')
        RETURNING *;
        SQL
        result = @db.exec(command).first
        build_artist(result)
      end

      def get_artists
        command = <<-SQL
        SELECT * FROM artists;
        SQL
        result = @db.exec(command).entries
        result.map { |row| build_artist(row) }
      end

      def get_artist(artist_id)
        command = <<-SQL
        SELECT * FROM artists WHERE id = '#{artist_id}';
        SQL
        result = @db.exec(command).first
        build_artist(result)
      end

      def build_artist(row)
        Songify::Artist.new(
          name: row['name'],
          id: row['id'].to_i
        )
      end
    end
  end
end