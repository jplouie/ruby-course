module PuppyBreeder
	class PuppyList < Hash
		# creates a hash with customer's name as the key and puppy as the value
		def []=(customer, puppy)
			if !self.key?(customer)
				self.store(customer, [puppy])
			else
				self[customer] << puppy
			end
		end

	end
end