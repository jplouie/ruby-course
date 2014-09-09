require 'server_spec_helper'

describe Bookly::Server do

  def app
    Bookly::Server.new
  end

  describe "GET /" do
    it "loads the homepage" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include "Welcome"
    end
  end
end