require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
	let(:request) { PuppyBreeder::PurchaseRequest.new(breed: "poodle", color: "white") }

	describe "#initialize" do
		it "should initialize a purchase request with puppy breed and color" do
			expect(request.breed).to eq('poodle')
			expect(request.color).to eq('white')
		end
	end
end