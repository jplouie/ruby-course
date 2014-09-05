require_relative 'spec_helper.rb'

describe PuppyBreeder::Puppy do
	let(:poodle) { PuppyBreeder::Breed.new(breed: 'poodle', price: 1500) }
	let(:pitbull) { PuppyBreeder::Breed.new(breed: 'pitbull', price: 800) }
	let(:shiba_inu) { PuppyBreeder::Breed.new(breed: 'shiba inu', price: 2000) }
	let(:terrier) { PuppyBreeder::Breed.new(breed: 'terrier', price: 1200) }
	let(:puppy) { PuppyBreeder::Puppy.new(name: "Lucky", breed: "poodle", color: "white", age: 5) }
	let(:puppy2) { PuppyBreeder::Puppy.new(name: "Brutus", breed: "pitbull", color: "black", age: 8) }

	describe "#initialize" do
		it "should initialize an instance puppy with breed, color, & price" do
			expect(puppy).to be_kind_of(PuppyBreeder::Puppy)
			expect(puppy.breed).to eq('poodle')
			expect(puppy2.name).to eq('Brutus')
			expect(puppy2.color).to eq('black')
		end
	end
end