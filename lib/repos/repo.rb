require 'pg'

module PuppyBreeder
	module Repositories
		class Repo
			def initialize
				@db = PG.connect(host: 'localhost', dbname: 'puppy-breeder-db')
			end
		end
	end
end
