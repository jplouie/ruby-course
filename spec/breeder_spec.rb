require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:breeder) { PuppyBreeder::Breeder.new("Carl") }
	let(:puppy) { PuppyBreeder::Puppy.new(name: "Lucky", breed: "terrier", color: "white", age: 5) }
	let(:puppy2) { PuppyBreeder::Puppy.new(name: "Brutus", breed: "pitbull", color: "black", age: 8) }
	let(:puppy3) { PuppyBreeder::Puppy.new(name: "Sprinkles", breed: "poodle", color: "tan", age: 14) }
	let(:request1) { PuppyBreeder::PurchaseRequest.new(breed: "terrier", color: "white") }
	let(:request2) { PuppyBreeder::PurchaseRequest.new(breed: "pitbull", color: "black") }
	let(:request3) { PuppyBreeder::PurchaseRequest.new(breed: "poodle", color: "tan") }
	let(:customer) { PuppyBreeder::Customer.new("Tina") }
	let(:customer2) { PuppyBreeder::Customer.new("Mark") }

	describe '#initialize' do
		it "should set a name for the breeder and create empty for_sale, purchase_requests, completed_purchases, and on_hold lists" do
			expect(breeder.name).to eq('Carl')
			expect(breeder.purchase_requests.length).to eq(0)
			expect(breeder.for_sale.length).to eq(0)
		end
	end

	describe '#add_purchase_request' do
		it "adds a purchase request to a purchase request list" do
			breeder.add_purchase_request(customer, request1)
			expect(breeder.purchase_requests[customer.name.to_sym].first.color).to eq('white')
		end
	end

	describe '#add_puppy_for_sale' do
		it "adds a puppy for sale to the for sale list" do
			breeder.add_puppy_for_sale(puppy3)
			expect(breeder.for_sale[breeder.name.to_sym].first.breed).to eq('poodle')

			breeder.add_puppy_for_sale(puppy3)
			expect(breeder.for_sale[breeder.name.to_sym].length).to eq(2)
		end
	end

	describe '#print_purchase_requests' do
		it "should puts each customer's name and puppy request" do
			breeder.add_purchase_request(customer, request1)
			breeder.add_purchase_request(customer2, request2)
			expect(breeder.print_purchase_requests[customer2.name.to_sym].first.breed).to eq(puppy2.breed)

			# STDOUT.should_receive(:puts).exactly(2).times
			# breeder.print_purchase_requests			
		end
	end

	describe '#make_transaction' do
		it "moves the purchase order to the completed order hash" do
			breeder.add_puppy_for_sale(puppy)
			breeder.add_purchase_request(customer, request1)
			breeder.make_transaction(customer, request1)
			expect(breeder.purchase_requests[customer.name.to_sym].first.status).to eq('completed')
		end
	end

	describe '#view_completed_purchases' do
		it "should puts each completed purchase order with the customer's name" do
			breeder.add_puppy_for_sale(puppy)
			breeder.add_purchase_request(customer, request1)
			breeder.make_transaction(customer, request1)
			breeder.add_puppy_for_sale(puppy2)
			breeder.add_purchase_request(customer2, request2)
			breeder.make_transaction(customer2, request2)
			expect(breeder.purchase_requests[customer2.name.to_sym].first.status).to eq('completed')

			# STDOUT.should_receive(:puts).exactly(2).times
			# breeder.view_completed_purchases
		end
	end

	describe '#hold?' do
		it "puts a purchase request on hold if requested puppy is not available" do
			breeder.add_purchase_request(customer, request1)
			expect(breeder.purchase_requests.length).to eq(1)
			expect(breeder.purchase_requests[customer.name.to_sym].first.status).to eq('hold')
		end
	end

	describe '#remove_hold?' do
		it "takes the customer first in line off hold if puppy requested is added to puppies for sale" do
			breeder.add_purchase_request(customer2, request2)
			breeder.add_purchase_request(customer, request1)
			expect(breeder.purchase_requests.length).to eq(2)

			breeder.add_puppy_for_sale(puppy2)
			expect(breeder.purchase_requests[customer2.name.to_sym].first.status).to eq('none')
		end
	end
end