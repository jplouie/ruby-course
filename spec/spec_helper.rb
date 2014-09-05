#require this file in your spec files to help DRY up your tests
require 'rspec'
require 'pry-byebug'
require_relative '../lib/puppy_breeder.rb'

def create_tables
  PuppyBreeder::Repositories.create_tables
end

def drop_tables
  PuppyBreeder::Repositories.drop_tables
end