#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
  	attr_reader :breed, :color, :id
  	attr_accessor :customer, :status, :puppy, :hold_number

  	def initialize(params)
  		@breed = params[:breed]
      @color = params[:color]
  		@customer = params[:customer]
  		@status = params[:status]
  		@hold_number = params[:hold_number]
  		@puppy = params[:puppy]
      @id = params[:id]
  	end
  end
end