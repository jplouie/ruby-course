require_relative 'repo.rb'

module PuppyBreeder
	module Repositories
		class PurchaseRequests < Repo
      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS requests(
          id SERIAL PRIMARY KEY,
          breed integer REFERENCES breeds(id),
          color text,
          customer text,
          status text,
          puppy integer REFERENCES puppies(id)
        );
        SQL
        @db.exec(command)
      end

      def reset_table
        command = <<-SQL
        DROP TABLE IF EXISTS requests CASCADE;
        SQL
        @db.exec(command)
      end

      def add(request)
        breed_id = PuppyBreeder.breeds_repo.get_breed_id(request.breed)

        command = <<-SQL
        INSERT INTO requests(breed, color, customer, status)
        VALUES ('#{breed_id}', '#{request.color}', '#{request.customer}', '#{request.status}')
        RETURNING *;
        SQL
        result = @db.exec(command).first
        build_request(result)
      end

      def update_status(request, new_status)
        command = <<-SQL
        UPDATE requests
        SET status = '#{new_status}'
        WHERE id = '#{request.id}'
        RETURNING *;
        SQL
        result = @db.exec(command).first
        build_request(result)
      end

      def update_puppy(request, puppy)
        command = <<-SQL
        UPDATE requests
        SET puppy = '#{puppy.id}'
        WHERE id = '#{request.id}'
        RETURNING *;
        SQL
        result = @db.exec(command).first
        result['puppy'] = PuppyBreeder.puppies_repo.get_puppy(result['puppy'].to_i)

        build_request(result)
      end

      def get_requests
        command = <<-SQL
        SELECT * FROM requests;
        SQL
        results = @db.exec(command).entries
        results.map { |row| build_request(row) }
      end

      def build_request(row)
        breed = PuppyBreeder.breeds_repo.get_breed_string(row['breed'].to_i)

        PuppyBreeder::PurchaseRequest.new(
          breed: breed,
          color: row['color'],
          customer: row['customer'],
          status: row['status'],
          puppy: row['puppy'],
          id: row['id'].to_i
        )
      end
		end
	end
end