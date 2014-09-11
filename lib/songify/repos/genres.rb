require 'pg'
require 'pry-byebug'

module Songify
  module Repos
    class Genres
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'songs-db')
      end

      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS genres(
          id SERIAL PRIMARY KEY,
          name TEXT
          );
        SQL
        @db.exec(command)
      end

      def drop_table
        command = <<-SQL
        DROP TABLE IF EXISTS genres CASCADE;
        SQL
        @db.exec(command)
      end

      def add(genre)
        command = <<-SQL
        INSERT INTO genres(name)
        VALUES ('#{genre.name}')
        RETURNING *;
        SQL
        result = @db.exec(command).first
        build_genre(result)
      end

      def get_genres
        command = <<-SQL
        SELECT * FROM genres;
        SQL
        result = @db.exec(command).entries
        result.map { |row| build_genre(row) }
      end

      def get_genre(genre_id)
        command = <<-SQL
        SELECT * FROM genres WHERE id = '#{genre_id}';
        SQL
        result = @db.exec(command).first
        build_genre(result)
      end

      def get_genre_id(genre)
        command = <<-SQL
        SELECT * FROM genres WHERE name = '#{genre.name}';
        SQL
        @db.exec(command).first['id'].to_i
      end

      def get_genre_by_name(name)
        command = <<-SQL
        SELECT * FROM genres WHERE name = '#{name}';
        SQL
        result = @db.exec(command).first
        build_genre(result)
      end

      def delete(genre)
        command = <<-SQL
        DELETE FROM genres WHERE id = '#{genre.id}'
        SQL
        @db.exec(command)
      end

      def edit(genre, new_genre)
        command = <<-SQL
        UPDATE genres
        SET name = '#{new_genre}'
        WHERE id = '#{genre.id}'
        RETURNING *;
        SQL
        result = @db.exec(command)
        build_genre(result)
      end

      def build_genre(row)
        Songify::Genre.new(
          name: row['name'],
          id: row['id'].to_i
          )
      end
    end
  end
end