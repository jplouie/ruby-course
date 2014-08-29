module PuppyBreeder
	class Breeder
		attr_reader :name, :purchase_requests, :for_sale
		def initialize(name)
			@name = name
			@purchase_requests = PuppyBreeder::PuppyList.new
			@for_sale = PuppyBreeder::PuppyList.new
		end

		def add_purchase_request(customer)
			@purchase_requests.puppies[customer.name.to_sym] = customer.purchase_request
		end

		def add_puppy_for_sale(puppy)
			@for_sale.puppies[@name.to_sym] = puppy
		end
	end
end