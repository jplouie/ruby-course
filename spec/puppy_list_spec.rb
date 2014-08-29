require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyList do
	let(:list) { PuppyBreeder::PuppyList.new }
	let(:puppy) { PuppyBreeder::Puppy.new("poodle", "tan") }
	let(:bob) { PuppyBreeder::Customer.new("Bob") }

	describe '#initialize' do
		it "creates an empty hash" do
			expect(list).to be_kind_of(PuppyBreeder::PuppyList)
			expect(list.length).to eq(0)
		end
	end

	describe '#add' do
		it "adds a new puppy to the list" do
			list.add(bob, puppy)
			expect(list[bob.name.to_sym]).to be_kind_of(PuppyBreeder::Puppy)
		end
	end
end