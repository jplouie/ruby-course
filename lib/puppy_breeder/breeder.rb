module PuppyBreeder
	class Breeder
		attr_reader :name, :purchase_requests, :for_sale, :completed_purchases, :on_hold
		def initialize(name)
			@name = name
			@hold_count = 0
			@purchase_requests = PuppyBreeder::PuppyList.new
			@for_sale = PuppyBreeder::PuppyList.new
		end

		def add_purchase_request(customer, purchase_request)
			purchase_request.customer = customer.name
			@purchase_requests[customer.name.to_sym] = purchase_request
			hold?(purchase_request)
		end

		def add_puppy_for_sale(puppy)
			@for_sale[@name.to_sym] = puppy
			remove_hold?(puppy)
		end

		def print_purchase_requests
			@purchase_requests
		end

		def check(purchase_request)
			@for_sale.each do |breeder, puppy_array|
				puppy_array.each_index do |i|
					if (purchase_request.breed == puppy_array[i].breed) && 
						(purchase_request.color == puppy_array[i].color)
						return i
					end
				end
			end
			return nil
		end

		def make_transaction(customer, purchase_request)
			i = check(purchase_request)
			if i >= 0
				@purchase_requests[customer.name.to_sym]
				.select { |request| request.breed == purchase_request.breed}
				.first.status = 'pending'
				@purchase_requests[customer.name.to_sym]
				.select { |request| request.status == 'pending' }
				.first.puppy = @for_sale[@name.to_sym][i]
				@purchase_requests[customer.name.to_sym]
				.select { |request| request.status == 'pending'}
				.first.status = 'completed'
				@for_sale[@name.to_sym].delete_at(i)
			end
			@completed_purchases
		end

		def view_completed_purchases
			@purchase_requests.select { |customer, request| request.status == 'completed' }
		end

		def hold?(purchase_request)
			i = check(purchase_request)
			if i == nil
				purchase_request.status = 'hold'
				purchase_request.hold_number = @hold_count
				@hold_count += 1
			end
		end

		def remove_hold?(puppy)
			first_hold = nil
			# @purchase_requests.select do |customer, request|
			# 	request.select { |req| req.status == 'hold' }
			# end
			@purchase_requests.select { |customer, request| request.first.status == 'hold' }
			.each do |customer_key, request|
				if (request.first.breed == puppy.breed) && (request.first.color == puppy.color)
					if (first_hold == nil) || (first_hold.hold_number > request.hold_number)
						first_hold = request
					end
				end
			end
			if first_hold
				first_hold.first.status = 'none'
			end
		end
	end
end