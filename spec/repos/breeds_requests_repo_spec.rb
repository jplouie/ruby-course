require_relative '../spec_helper.rb'

describe PuppyBreeder::Repositories::BreedsRequests do
  let(:terrier) { PuppyBreeder::Breed.new(breed: 'terrier', price: 2400) }
  let(:poodle) { PuppyBreeder::Breed.new(breed: 'poodle', price: 2000) }
  let(:pitbull) { PuppyBreeder::Breed.new(breed: 'pitbull', price: 700) }
  let(:shiba) { PuppyBreeder::Breed.new(breed: 'shiba_inu', price: 1500 ) }
  let(:request1) { PuppyBreeder::PurchaseRequest.new(breed: ['terrier'], customer: 'Bob') }
  let(:request2) { PuppyBreeder::PurchaseRequest.new(breed: ['pitbull', 'poodle'], customer: 'Natalie') }
  let(:request3) { PuppyBreeder::PurchaseRequest.new(breed: ['terrier', 'poodle', 'shiba_inu', customer: 'Ryan']) }

  before :all do
    @puppies_repo = PuppyBreeder::Repositories::Puppies.new
    @breeds_repo = PuppyBreeder::Repositories::Breeds.new
    @requests_repo = PuppyBreeder::Repositories::PurchaseRequests.new
    @breeds_requests_repo = PuppyBreeder::Repositories::BreedsRequests.new
  end

  before do
    PuppyBreeder::Repositories.drop_tables
    PuppyBreeder::Repositories.create_tables
  end

  describe 'adds breeds id and purchase request id combos' do
    describe 'adds and gets any number of breeds with the same request id' do
      xit 'adds the number of breeds to the table that the customer requests' do
        @breeds_repo.add(terrier)
        @breeds_repo.add(poodle)
        @breeds_repo.add(pitbull)
        @breeds_repo.add(shiba)
        @requests_repo.add(request1)
        @requests_repo.add(request2)
        @requests_repo.add(request3)
        result = @breeds_requests_repo.add(request1)
        expect(result).to be_an(Array)
        expect(result.length).to eq(1)
        expect(result.first).to eq('terrier')
        result = @breeds_requests_repo.add(request2)
        expect(result.length).to eq(2)
        result = @breeds_requests_repo.add(request3)
        expect(result[2]).to eq('shiba_inu')
      end

      xit 'gets the desired breeds per purchase request' do
        @breeds_repo.add(terrier)
        @breeds_repo.add(poodle)
        @breeds_repo.add(pitbull)
        @breeds_repo.add(shiba)
        customer1 = @requests_repo.add(request1)
        customer2 = @requests_repo.add(request2)
        customer3 = @requests_repo.add(request3)
        @requests_repo.add(request3)
        @breeds_requests_repo.get_breeds()
      end
    end
  end
end