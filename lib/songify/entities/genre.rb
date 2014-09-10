module Songify
  class Genre
    attr_reader :name, :id
    def initialize(params)
      @name = params[:name]
      @id = params[:id]
    end
  end
end