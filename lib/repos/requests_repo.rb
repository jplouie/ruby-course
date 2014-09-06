require_relative 'repo.rb'

module PuppyBreeder
	module Repositories
		class PurchaseRequests < Repo
      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS requests(
          id SERIAL PRIMARY KEY,
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
        command = <<-SQL
        INSERT INTO requests(customer, status)
        VALUES ('#{request.customer}', '#{request.status}')
        RETURNING *;
        SQL
        result = @db.exec(command).first
        PuppyBreeder.breeds_requests_repo.add(result, request.breed)

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
        breed_ids = PuppyBreeder.breeds_requests_repo.get_breeds_ids(row['id'].to_i)
        breeds = breed_ids.map { |id| PuppyBreeder.breeds_repo.get_breed_string(id) }

        PuppyBreeder::PurchaseRequest.new(
          breed: breeds,
          customer: row['customer'],
          status: row['status'],
          puppy: row['puppy'],
          id: row['id'].to_i
        )
      end
		end
	end
end