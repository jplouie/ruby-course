require_relative 'spec_helper.rb'

describe PuppyBreeder::Breed do
	describe '#initialize' do
		it "should create an empty hash of dog breeds and prices" do
			terrier = PuppyBreeder::Breed.new(breed: 'terrier', price: 2400)
			expect(terrier.breed).to eq('terrier')
      expect(terrier.price).to eq(2400)
		end
	end
end