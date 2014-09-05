require_relative 'spec_helper.rb'

describe PuppyBreeder::Customer do
	let(:bob) { PuppyBreeder::Customer.new('Bob') }

	describe '#initialize' do
		it "should initialize with a name" do
			expect(bob.name).to eq('Bob')
			expect(bob.purchase_request).to be_nil
		end
	end
end