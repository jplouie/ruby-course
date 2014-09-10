require_relative '../lib/bookly.rb'
require 'sinatra/base'

class Bookly::Server < Sinatra::Application
  get '/' do
    @books = Bookly.books_repo.all
    erb :index
  end

  post '/books' do
    book = Bookly::Book.new(params["name"], Date.parse(params["published_at"]))
    Bookly.books_repo.save(book)
    book.name
  end
end