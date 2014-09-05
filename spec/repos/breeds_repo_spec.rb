require_relative '../spec_helper.rb'

describe PuppyBreeder::Repositories::Breeds do
  let(:terrier) { PuppyBreeder::Breed.new(breed: 'terrier', price: 2400) }
  let(:poodle) { PuppyBreeder::Breed.new(breed: 'poodle', price: 2000) }
  before :all do
    @breeds_repo = PuppyBreeder::Repositories::Breeds.new
  end

  before do
    PuppyBreeder::Repositories.drop_tables
    PuppyBreeder::Repositories.create_tables
  end

  describe 'adds and retrieves breeds' do
    it 'returns no breeds if none are added' do
      result = @breeds_repo.get_breeds.entries
      expect(result).to be_an(Array)
      expect(result.length).to eq(0)
    end

    it 'adds a breed and gives it an id' do
      result = @breeds_repo.add(terrier)
      expect(result).to be_a(PuppyBreeder::Breed)
      expect(result.breed).to eq('terrier')
      expect(result.id).to be_a(Fixnum)
    end 

    it 'returns an array of breed instances' do
      @breeds_repo.add(terrier)
      @breeds_repo.add(poodle)
      result = @breeds_repo.get_breeds
      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result[1].breed).to eq('poodle')
    end
  end

  describe '#update_price' do
    it 'updates the price of the existing breed' do
      result = @breeds_repo.add(terrier)
      expect(result.breed).to eq('terrier')
      result2 = @breeds_repo.update_price(terrier, 1500)
      expect(result2.price).to eq(1500)
    end
  end
end
