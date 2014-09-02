require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:breeder) { PuppyBreeder::Breeder.new("Carl") }
	let(:puppy) { PuppyBreeder::Puppy.new("Lucky", "terrier", "white", 5) }
	let(:puppy2) { PuppyBreeder::Puppy.new("Brutus", "pitbull", "black", 8) }
	let(:puppy3) { PuppyBreeder::Puppy.new("Sprinkles", "poodle", "tan", 14) }
	let(:customer) { PuppyBreeder::Customer.new("Tina") }
	let(:customer2) { PuppyBreeder::Customer.new("Mark") }

	describe '#initialize' do
		it "should set a name for the breeder and create empty for_sale, purchase_requests, completed_purchases, and on_hold lists" do
			expect(breeder.name).to eq('Carl')
			expect(breeder.purchase_requests.length).to eq(0)
			expect(breeder.for_sale.length).to eq(0)
			expect(breeder.completed_purchases.length).to eq(0)
		end
	end

	describe '#add_purchase_request' do
		it "adds a purchase request to a purchase request list" do
			breeder.add_puppy_for_sale(puppy)
			customer.create_purchase_request("terrier", "white")
			breeder.add_purchase_request(customer)
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
			breeder.add_puppy_for_sale(puppy)
			breeder.add_puppy_for_sale(puppy2)
			customer.create_purchase_request(puppy.breed, puppy.color)
			breeder.add_purchase_request(customer)
			customer2.create_purchase_request(puppy2.breed, puppy2.color)
			breeder.add_purchase_request(customer2)
			expect(breeder.print_purchase_requests[customer2.name.to_sym].first.breed).to eq(puppy2.breed)

			# STDOUT.should_receive(:puts).exactly(2).times
			# breeder.print_purchase_requests			
		end
	end

	describe '#make_transaction' do
		it "moves the purchase order to the completed order hash" do
			breeder.add_puppy_for_sale(puppy)
			customer.create_purchase_request(puppy.breed, puppy.color)
			breeder.add_purchase_request(customer)
			breeder.make_transaction(customer)
			expect(breeder.purchase_requests.length).to eq(0)
			expect(breeder.completed_purchases[customer.name.to_sym].first.breed).to eq('terrier')
		end
	end

	describe '#view_completed_purchases' do
		it "should puts each completed purchase order with the customer's name" do
			breeder.add_puppy_for_sale(puppy)
			customer.create_purchase_request(puppy.breed, puppy.color)
			breeder.add_purchase_request(customer)
			breeder.make_transaction(customer)
			breeder.add_puppy_for_sale(puppy2)
			customer2.create_purchase_request(puppy2.breed, puppy2.color)
			breeder.add_purchase_request(customer2)
			breeder.make_transaction(customer2)
			expect(breeder.completed_purchases[customer2.name.to_sym].first).to be_kind_of(PuppyBreeder::Puppy)

			# STDOUT.should_receive(:puts).exactly(2).times
			# breeder.view_completed_purchases
		end
	end

	describe '#hold?' do
		it "puts a purchase request on hold if requested puppy is not available" do
			customer.create_purchase_request(puppy.breed, puppy.color)
			breeder.add_purchase_request(customer)
			expect(breeder.purchase_requests.length).to eq(0)
			expect(breeder.on_hold.first.name).to eq('Tina')
		end
	end

	describe '#unhold?' do
		it "takes the customer first in line off hold if puppy requested is added to puppies for sale" do
			customer.create_purchase_request(puppy.breed, puppy.color)
			customer2.create_purchase_request(puppy.breed, puppy.color)
			breeder.add_purchase_request(customer)
			breeder.add_purchase_request(customer2)
			expect(breeder.on_hold.length).to eq(2)

			breeder.add_puppy_for_sale(puppy)
			expect(breeder.purchase_requests.length).to eq(1)
			expect(breeder.on_hold.first.name).to eq('Mark')
		end
	end
end