module Songify
  class Song
    attr_reader :name, :artist, :id, :genre

    def initialize(params)
      @name = params[:name]
      @artist = params[:artist]
      @genre = params[:genre]
      @id = params[:id]
    end
  end
end