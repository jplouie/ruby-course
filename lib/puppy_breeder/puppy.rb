#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_reader :breed, :color, :price
  	initialize(breed, color, price = nil)
  		@breed, @color, @price = breed, color, price
  	end
  end
end