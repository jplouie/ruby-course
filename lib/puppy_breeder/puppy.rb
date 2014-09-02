#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_reader :name, :breed, :color, :age
  	def initialize(name, breed, color, age)
  		@name, @breed, @color, @age = name, breed, color, age
  	end
  end
end