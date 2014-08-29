require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
	let(:puppy) { PuppyBreeder::Puppy.new("poodle", "white", 1000) }
	let(:puppy2) { PuppyBreeder::Puppy.new("pitbull", "black") }

	describe "#initialize" do
		it "should initialize an instance puppy with breed, color, & price" do
			expect(puppy).to be_kind_of(PuppyBreeder::Puppy)
			expect(puppy.breed).to eq('poodle')
			expect(puppy2.price).to be_nil
			expect(puppy2.color).to eq('black')
		end
	end
end