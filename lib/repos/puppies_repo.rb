require_relative 'repo.rb'

module PuppyBreeder
  module Repositories
    class Puppies < Repo
      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS puppies(
          id SERIAL PRIMARY KEY,
          name text,
          breed integer REFERENCES breeds(id),
          color text,
          age integer,
          status text
        );
        SQL
        @db.exec(command)
      end

      def reset_table
        command = <<-SQL
        DROP TABLE IF EXISTS puppies CASCADE;
        SQL
        @db.exec(command)
      end

      def add(puppy)
        breed_id = PuppyBreeder.breeds_repo.get_breed_id(puppy.breed)

        command = <<-SQL
        INSERT INTO puppies(name, breed, color, age, status)
        VALUES ('#{puppy.name}', '#{breed_id}', '#{puppy.color}', '#{puppy.age}', 'available')
        RETURNING *;
        SQL
        result = @db.exec(command).first
        build_puppy(result)
      end

      def update_status(puppy)
        command = <<-SQL
        UPDATE puppies
        SET status = 'sold'
        WHERE id = '#{puppy.id}'
        RETURNING *;
        SQL
        result = @db.exec(command).first
        build_puppy(result)
      end

      def get_puppies
        command = <<-SQL
        SELECT * FROM puppies;
        SQL
        result = @db.exec(command).entries
        result.map { |row| build_puppy(row) }
      end

      def get_puppy(id)
        get_puppy_command = <<-SQL
        SELECT * FROM puppies WHERE id = '#{id}';
        SQL
        result = @db.exec(get_puppy_command).first
        build_puppy(result)
      end

      def build_puppy(row)
        breed = PuppyBreeder.breeds_repo.get_breed_string(row['breed'].to_i)

        PuppyBreeder::Puppy.new(
          name: row['name'],
          breed: breed,
          color: row['color'],
          age: row['age'].to_i,
          id: row['id'].to_i,
          status: row['status']
        )
      end
    end
  end
end