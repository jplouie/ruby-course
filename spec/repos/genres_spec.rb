require_relative '../spec_helper.rb'

describe Songify::Repos::Genres do
  let(:genre1) { Songify::Genre.new(name: 'Rock') }
  let(:genre2) { Songify::Genre.new(name: 'Alternative') }
  let(:genre3) { Songify::Genre.new(name: 'Pop') }

  before :all do
    @genres = Songify::Repos::Genres.new
  end

  before do
    Songify.genres_repo.drop_table
    Songify.genres_repo.create_table
  end

  describe 'can save and get genre names' do
    it 'returns no genres if none are added' do
      result = Songify.genres_repo.get_genres
      expect(result.length).to eq(0)
    end

    it 'saves a genre and gives it an id' do
      result = Songify.genres_repo.add(genre1)
      expect(result).to be_a(Songify::Genre)
      expect(result.id).to eq(1)
    end

    it 'returns all genres' do
      Songify.genres_repo.add(genre1)
      Songify.genres_repo.add(genre2)
      Songify.genres_repo.add(genre3)
      result = Songify.genres_repo.get_genres
      expect(result.length).to eq(3)
      expect(result[2].name).to eq('Pop')
    end

    it 'get a genre by its id' do
      genre_with_id = Songify.genres_repo.add(genre2)
      result = Songify.genres_repo.get_genre(genre_with_id.id)
      expect(result.name).to eq(genre2.name)
    end
  end

  describe '#delete' do
    it 'deletes an existing genre' do
      genre_with_id = Songify.genres_repo.add(genre1)
      Songify.genres_repo.add(genre3)
      Songify.genres_repo.delete(genre_with_id)
      result = Songify.genres_repo.get_genres
      expect(result.length).to eq(1)
    end
  end
end