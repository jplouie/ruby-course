require_relative 'repo.rb'

module PuppyBreeder
  module Repositories
    class BreedsRequests < Repo
      def create_table
        command = <<-SQL
        CREATE TABLE IF NOT EXISTS breeds_requests(
          id SERIAL PRIMARY KEY,
          request_id integer REFERENCES requests(id),
          breed_id integer REFERENCES breeds(id)
          );
        SQL
        @db.exec(command)
      end

      def reset_table
        command = <<-SQL
        DROP TABLE IF EXISTS breeds_requests CASCADE;
        SQL
        @db.exec(command)
      end

      def add(row, breeds)
        request = row['id']
        breeds.map do |breed|
          id = PuppyBreeder.breeds_repo.get_breed_id(breed)
          command = <<-SQL
          INSERT INTO breeds_requests(breed_id, request_id)
          VALUES ('#{id}', '#{request}');
          SQL
          @db.exec(command)
        end
      end

      def get_breeds_ids(id)
        command = <<-SQL
        SELECT breed_id FROM breeds_requests WHERE request_id = '#{id}';
        SQL
        @db.exec(command).entries.map { |breed| breed.values.first.to_i }
      end
    end
  end
end