require_relative 'spec_helper.rb'

describe PuppyBreeder::Breeder do
	let(:breeder) { PuppyBreeder::Breeder.new("Carl") }
	let(:puppy) { PuppyBreeder::Puppy.new("terrier", "white") }
	let(:puppy2) { PuppyBreeder::Puppy.new("pitbull", "black") }
	let(:customer) { PuppyBreeder::Customer.new("Tina") }
	let(:customer2) { PuppyBreeder::Customer.new("Mark") }

	describe '#initialize' do
		it "should set a name for the breeder" do
			expect(breeder.name).to eq('Carl')
			expect(breeder.purchase_requests.length).to eq(0)
			expect(breeder.for_sale.length).to eq(0)
		end
	end

	describe '#add_purchase_request' do
		it "adds a purchase request to a purchase request list" do
			breeder.add_purchase_request(puppy, customer)
			expect(breeder.purchase_requests[customer.name.to_sym].color).to eq('white')
		end
	end

	describe '#add_puppy_for_sale' do
		it "adds a puppy for sale to the for sale list" do
			breeder.add_puppy_for_sale(puppy2)
			expect(breeder.for_sale[breeder.name_to_sym].breed).to eq('pitbull')
		end
	end

	describe '#print_purchase_requests' do
		it "should puts each customer's name and puppy request" do
			breeder.add_purchase_request(puppy, customer)
			breeder.add_purchase_request(puppy2, customer2)
			STDOUT.should_receive(:puts).exactly(2).times
			breeder.print_purchase_requests
		end
	end

	describe '#make_transaction' do
		it "moves the purchase order to the completed order hash" do
			breeder.add_purchase_request(puppy, customer)
			breeder.make_transaction(customer)
			expect(breeder.purchase_requests.length).to eq(0)
			expect(breeder.completed_purchases[customer.name.to_sym].breed).to eq('terrier')
		end
	end

	describe '#view_completed_purchases' do
		it "should puts each completed purchase order with the customer's name" do
			breeder.add_purchase_request(puppy, customer)
			breeder.add_purchase_request(puppy2, customer2)
			STDOUT.should_receive(:puts).exactly(2).times
			breeder.view_completed_purchases
		end
	end
end