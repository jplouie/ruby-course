require_relative '../spec_helper.rb'

describe PuppyBreeder::Repositories::PurchaseRequests do
  let(:terrier) { PuppyBreeder::Breed.new(breed: 'terrier', price: 2400) }
  let(:poodle) { PuppyBreeder::Breed.new(breed: 'poodle', price: 2000) }
  let(:pitbull) { PuppyBreeder::Breed.new(breed: 'pitbull', price: 700) }
  let(:puppy) { PuppyBreeder::Puppy.new(name: "Lucky", breed: "terrier", color: "white", age: 5) }
  let(:puppy2) { PuppyBreeder::Puppy.new(name: "Brutus", breed: "pitbull", color: "black", age: 8) }
  let(:request) { PuppyBreeder::PurchaseRequest.new(breed: 'terrier', color: 'white', customer: 'Bob') }
  let(:request2) { PuppyBreeder::PurchaseRequest.new(breed: 'pitbull', color: 'black', customer: 'Natalie') }

  before :all do
    @puppies_repo = PuppyBreeder::Repositories::Puppies.new
    @breeds_repo = PuppyBreeder::Repositories::Breeds.new
    @requests_repo = PuppyBreeder::Repositories::PurchaseRequests.new
  end

  before do
    drop_tables
    create_tables
  end

  describe 'adds and retrieves purchase requests' do
    it 'returns no requests if none are added' do
      result = @requests_repo.get_requests
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it 'adds a request and gives it an id' do
      @breeds_repo.add(terrier)
      result = @requests_repo.add(request)
      expect(result).to be_a(PuppyBreeder::PurchaseRequest)
      expect(result.id).to be_a(Fixnum)
    end

    it 'returns an array of purchase requests' do
      @breeds_repo.add(terrier)
      @breeds_repo.add(poodle)
      @breeds_repo.add(pitbull)
      @requests_repo.add(request)
      @requests_repo.add(request2)
      result = @requests_repo.get_requests
      expect(result.length).to eq(2)
      expect(result[0].id).to eq(1)
      expect(result[1].breed).to eq('pitbull')
    end
  end

  describe '#update_status' do
    it 'changes the status to hold, completed, or none' do
      @breeds_repo.add(terrier)
      request_with_id = @requests_repo.add(request)
      result = @requests_repo.update_status(request_with_id, 'hold')
      expect(result.status).to eq('hold')
      result = @requests_repo.update_status(request_with_id, 'completed')
      expect(result.status).to eq('completed')
    end
  end

  describe '#update_puppy' do
    it 'adds a puppy id when the purchase request is completed' do
      @breeds_repo.add(pitbull)
      puppy_with_id = @puppies_repo.add(puppy2)
      request_with_id = @requests_repo.add(request2)
      request_completed = @requests_repo.update_status(request_with_id, 'completed')
      result = @requests_repo.update_puppy(request_completed, puppy_with_id)
      expect(result.puppy).to be_a(PuppyBreeder::Puppy)
      expect(result.puppy.name).to eq('Brutus')
    end
  end
end