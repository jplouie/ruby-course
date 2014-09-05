module PuppyBreeder
	class Breed
    attr_reader :breed, :price, :id
		def initialize(params)
      @breed = params[:breed]
      @price = params[:price]
      @id = params[:id]
    end
	end
end