require_relative '../spec_helper.rb'

describe PuppyBreeder::Repositories::Puppies do
  let(:terrier) { PuppyBreeder::Breed.new(breed: 'terrier', price: 2400) }
  let(:poodle) { PuppyBreeder::Breed.new(breed: 'poodle', price: 2000) }
  let(:pitbull) { PuppyBreeder::Breed.new(breed: 'pitbull', price: 700) }
  let(:puppy) { PuppyBreeder::Puppy.new(name: "Lucky", breed: "terrier", color: "white", age: 5) }
  let(:puppy2) { PuppyBreeder::Puppy.new(name: "Brutus", breed: "pitbull", color: "black", age: 8) }

  before :all do
    @puppies_repo = PuppyBreeder::Repositories::Puppies.new
    @breeds_repo = PuppyBreeder::Repositories::Breeds.new
  end

  before do
    drop_tables
    create_tables
  end

  describe 'adds and retrieves puppies' do
    it 'should return no puppies if none are added' do
      result = @puppies_repo.get_puppies
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it 'adds a puppy and gives it an id' do
      @breeds_repo.add(terrier)
      result = @puppies_repo.add(puppy)
      expect(result).to be_a(PuppyBreeder::Puppy)
      expect(result.id).to be_a(Fixnum)
    end

    it 'returns an array of puppies if multiple puppies are added' do
      @breeds_repo.add(terrier)
      @breeds_repo.add(poodle)
      @breeds_repo.add(pitbull)
      @puppies_repo.add(puppy)
      @puppies_repo.add(puppy2)
      result = @puppies_repo.get_puppies
      expect(result.length).to eq(2)
      expect(result[0].breed).to eq('terrier')
      expect(result[1].breed).to eq('pitbull')
      expect(result[1].id).to eq(2)
    end
  end

  describe '#update_status' do
    it 'updates the status to sold if puppy is sold' do
      @breeds_repo.add(terrier)
      puppy_with_id = @puppies_repo.add(puppy)
      expect(puppy_with_id.status).to eq('available')
      result = @puppies_repo.update_status(puppy_with_id)
      expect(result.status).to eq('sold')
    end
  end
end