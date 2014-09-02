require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
	let(:breeds) do
		PuppyBreeder::Breed.new
		breeds[:poodle] = 1500
		breeds[:pitbull] = 800
		breeds[:shiba_inu] = 2000
		breeds[:terrier] = 1200
	end
	let(:puppy) { PuppyBreeder::Puppy.new("Lucky", "poodle", "white", 5) }
	let(:puppy2) { PuppyBreeder::Puppy.new("Brutus", "pitbull", "black", 8) }

	describe "#initialize" do
		it "should initialize an instance puppy with breed, color, & price" do
			expect(puppy).to be_kind_of(PuppyBreeder::Puppy)
			expect(puppy.breed).to eq('poodle')
			expect(puppy2.name).to eq('Brutus')
			expect(puppy2.color).to eq('black')
		end
	end
end