#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
  	attr_reader :name, :breed, :color, :age, :id, :status
  	def initialize(params)
  		@name = params[:name]
      @breed = params[:breed]
      @color = params[:color]
      @age = params[:age]
      @id = params[:id]
      @status = params[:status]
  	end
  end
end