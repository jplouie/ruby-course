#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
  	attr_reader :breed, :color
  	def initialize(breed, color)
  		@breed, @color = breed, color
  	end
  end
end