# we initialize the module here to use in our other files
module PuppyBreeder
  module Repositories
  end
end

require_relative 'puppy_breeder/breed.rb'
require_relative 'puppy_breeder/breeder.rb'
require_relative 'puppy_breeder/customer.rb'
require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/puppy_list.rb'
require_relative 'puppy_breeder/purchase_request.rb'

require_relative 'repos/repo_init.rb'
# require_relative 'repos/breeds_repo.rb'

PuppyBreeder.breeds_repo = PuppyBreeder::Repositories::Breeds.new
PuppyBreeder.puppies_repo = PuppyBreeder::Repositories::Puppies.new
PuppyBreeder.requests_repo = PuppyBreeder::Repositories::PurchaseRequests.new
