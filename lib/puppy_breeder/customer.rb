module PuppyBreeder
	class Customer
		attr_reader :name, :purchase_request
		def initialize(name)
			@name = name.gsub(' ', '_')
			@purchase_request = nil
		end

		# def create_purchase_request(breed, color)
		# 	@purchase_request = PuppyBreeder::PurchaseRequest.new(breed, color)
		# end
	end
end