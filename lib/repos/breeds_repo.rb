require_relative 'repo.rb'

module PuppyBreeder
	module Repositories
		class Breeds < Repo
      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS breeds(
          id SERIAL PRIMARY KEY,
          breed text,
          price integer
        );
        SQL
        @db.exec(command)
      end

      def reset_table
        command = <<-SQL
        DROP TABLE IF EXISTS breeds CASCADE;
        SQL
        @db.exec(command)
      end

			def add(breed)
				command = <<-SQL
				INSERT INTO breeds(breed, price)
				VALUES ('#{breed.breed}', '#{breed.price}')
        RETURNING *;
				SQL
				result = @db.exec(command).first
        build_breed(result)
			end

			def update_price(breed, input_price)
				command = <<-SQL
				UPDATE breeds
				SET price = '#{input_price}'
        WHERE breed = '#{breed.breed}'
        RETURNING *;
				SQL
				result = @db.exec(command).first
        build_breed(result)
			end

      def get_breeds
        command = <<-SQL
        SELECT * FROM breeds;
        SQL
        result = @db.exec(command).entries
        result.map { |row| build_breed(row) }
      end

      def get_breed_string(id)
        command = <<-SQL
        SELECT breed FROM breeds WHERE id = '#{id}';
        SQL
        @db.exec(command).first['breed']
      end

      def get_breed_id(breed)
        get_breed_id_command = <<-SQL
        SELECT id FROM breeds WHERE breed = '#{breed}';
        SQL
        @db.exec(get_breed_id_command).first['id'].to_i
      end

      def build_breed(row)
        PuppyBreeder::Breed.new(
          breed: row['breed'],
          price: row['price'].to_i,
          id: row['id'].to_i
        )
      end
		end
	end
end
