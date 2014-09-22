module Songify
  class Song
    attr_reader :name, :id, :genre, :lyrics
    attr_accessor :artist

    def initialize(params)
      @name = params[:name]
      @artist = params[:artist]
      @genre = params[:genre]
      @lyrics = params[:lyrics]
      @id = params[:id]
    end
  end
end