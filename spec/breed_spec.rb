require_relative 'spec_helper.rb'

describe PuppyBreeder::Breed do
	describe '#initialize' do
		it "should create an empty hash of dog breeds and prices" do
			breed = PuppyBreeder::Breed.new
			expect(breed.length).to eq(0)
		end
	end
end