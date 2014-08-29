require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyList do
	let(:list) { PuppyBreeder::PuppyList.new }
	let(:puppy) { PuppyBreeder::Puppy.new("poodle", "tan") }
	let(:customer) { PuppyBreeder::Customer.new("Bob") }

	describe '#initialize' do
		it "creates an empty hash" do
			expect(list).to be_kind_of(PuppyBreeder::PuppyList)
			expect(list.length).to eq(0)
		end
	end

	describe '#add' do
		it "adds a new puppy to the list" do
			list[customer.name.to_sym] = puppy
			expect(list[customer.name.to_sym].first).to be_kind_of(PuppyBreeder::Puppy)
		end
	end
end