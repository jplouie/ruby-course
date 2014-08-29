module PuppyBreeder
	class PuppyList
		attr_reader :puppies
		def initialize
			@puppies = {}
		end

		def add(puppy, customer = self.name.to_sym)
			@puppies[customer.name.to_sym] = puppy
		end
	end
end