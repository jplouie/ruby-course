module PuppyBreeder
	class Breeder
		attr_reader :name, :purchase_requests, :for_sale, :completed_purchases
		def initialize(name)
			@name = name
			@purchase_requests = PuppyBreeder::PuppyList.new
			@for_sale = PuppyBreeder::PuppyList.new
			@completed_purchases = PuppyBreeder::PuppyList.new
		end

		def add_purchase_request(customer)
			@purchase_requests[customer.name.to_sym] = customer.purchase_request
		end

		def add_puppy_for_sale(puppy)
			@for_sale[@name.to_sym] = puppy
		end

		def print_purchase_requests
			@purchase_requests
		end

		def check_transaction(customer)
			@for_sale.each do |breeder, puppy_array|
				puppy_array.each_index do |i|
					if (customer.purchase_request.breed == puppy_array[i].breed) && (customer.purchase_request.color == puppy_array[i].color)
						return i
					end
				end
			end
			return nil
		end

		def make_transaction(customer)
			i = check_transaction(customer)
			if i >= 0
				@completed_purchases[customer.name.to_sym] = @for_sale[@name.to_sym][i]
				@for_sale[@name.to_sym].delete_at(i)
				@purchase_requests.delete(customer.name.to_sym)
			end
			@completed_purchases
		end

		def view_completed_purchases
			@completed_purchases
		end
	end
end