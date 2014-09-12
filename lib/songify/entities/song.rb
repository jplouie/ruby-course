module Songify
  class Song
    attr_reader :name, :artist, :id, :genre, :lyrics

    def initialize(params)
      @name = params[:name]
      @artist = params[:artist]
      @genre = params[:genre]
      @lyrics = params[:lyrics]
      @id = params[:id]
    end
  end
end