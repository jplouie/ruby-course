module Songify
  class Song
    attr_reader :name, :artist, :id

    def initialize(params)
      @name = params[:name]
      @artist = params[:artist]
      @id = params[:id]
    end
  end
end