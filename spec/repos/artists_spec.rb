require_relative '../spec_helper.rb'

describe Songify::Repos::Artists do
  let(:artist1) { Songify::Artist.new(name: 'Yellowcard') }
  let(:artist2) { Songify::Artist.new(name: 'Kaskade') }
  before do
    Songify.artists_repo.drop_table
    Songify.artists_repo.create_table
  end

  describe 'it can save and get artists names' do
    it 'returns no artists if none are added' do
      result = Songify.artists_repo.get_artists
      expect(result.length).to eq(0)
    end

    it 'saves an artist and gives it an id' do
      result = Songify.artists_repo.add(artist1)
      expect(result).to be_an(Songify::Artist)
      expect(result.id).to be_a(Fixnum)
    end

    it 'returns all artists' do
      Songify.artists_repo.add(artist1)
      Songify.artists_repo.add(artist2)
      result = Songify.artists_repo.get_artists
      expect(result.length).to eq(2)
    end

    it 'gets an artist by its id' do
      Songify.artists_repo.add(artist1)
      Songify.artists_repo.add(artist2)
      result = Songify.artists_repo.get_artist(2)
      expect(result.name).to eq('Kaskade')
    end
  end
end