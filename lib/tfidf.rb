require_relative 'predictor'

class TFIDF < Predictor
  def train!
    @data = {}
    @data[:words] = Hash.new
    @data[:TF] = Hash.new
    @data[:IDF] = Hash.new
    @data[:TDIDF] = Hash.new
    @counts = Hash.new(0)
    
    @all_books.each do |category, books|
      @data[:words][category] = Hash.new(0)
      books.each do |filename, book|
        book.each do |token|
          @data[:words][category][token] += 1 if good_token?(token)
        end
      end
    end

    @data[:words].each do |category, words_count|
      max = words_count.values.max.to_f
      @data[:TF][category] = Hash.new(0)

      words_count.each do |word, count|
        @data[:TF][category][word] = count / max
        @counts[word] += 1
      end
    end

    @data[:words].each do |category, words_count|
      @data[:IDF][category] = Hash.new(0)
      @data[:TDIDF][category] = Hash.new(0)

      words_count.each do |word, count|
        @data[:IDF][category][word] = Math.log(4 / @counts[word].to_f)
        @data[:TDIDF][category][word] = 
        @data[:TF][category][word] * @data[:IDF][category][word]
      end
    end
  end


  def predict(tokens)
    largest = 0
    predicted_category = nil

    @data[:TDIDF].each do |category, tdidf|
      sum = 0
      tokens.each do |word|
        if @data[:TDIDF][category][word]
          sum += tdidf[word]
        end
      end

      if sum > largest
        largest = sum
        predicted_category = category
      end
    end
    predicted_category
  end
end

