require 'pg'

module PuppyBreeder
  def self.breeds_repo=(repo)
    @breeds_repo = repo
  end

  def self.breeds_repo
    @breeds_repo
  end

  def self.puppies_repo=(repo)
    @puppies_repo = repo
  end

  def self.puppies_repo
    @puppies_repo
  end

  def self.requests_repo=(repo)
    @requests_repo = repo
  end

  def self.requests_repo
    @requests_repo
  end

  def self.breeds_requests_repo=(repo)
    @breeds_requests_repo = repo
  end

  def self.breeds_requests_repo
    @breeds_requests_repo
  end

  module Repositories
    def self.create_tables
      PuppyBreeder.breeds_repo.create_table
      PuppyBreeder.puppies_repo.create_table
      PuppyBreeder.requests_repo.create_table
      PuppyBreeder.breeds_requests_repo.create_table
    end

    def self.drop_tables
      PuppyBreeder.breeds_repo.reset_table
      PuppyBreeder.puppies_repo.reset_table
      PuppyBreeder.requests_repo.reset_table
      PuppyBreeder.breeds_requests_repo.reset_table
    end
  end
end

require_relative 'breeds_repo.rb'
require_relative 'puppies_repo.rb'
require_relative 'requests_repo.rb'
require_relative 'breeds_requests_repo.rb'