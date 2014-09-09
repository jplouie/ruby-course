require_relative 'predictor'

class ComplexPredictor < Predictor
  # Public: Trains the predictor on books in our dataset. This method is called
  # before the predict() method is called.
  #
  # Returns nothing.
  def train!
    @data = {}
    @top_words = {}

    @all_books.each do |category, books|
      @data[category] = Hash.new(0)
      books.each do |filename, book|
        width = book.length/5
        shortened_book = book[0..width] + 
        book[(book.length/2 - width)..(book.length/2 + width)]

        shortened_book.each do |token|
          @data[category][token] += 1 if good_token?(token)
        end
      end
    end

    @data.each do |category, token_count|
      word_count = token_count.values.inject(:+).to_f
      tokens_values = token_count.map { |word, count| count / word_count }

      words = {}
      token_count.each do |word, count|
        word_value = count / word_count
        if word_value > (10 / tokens_values.length.to_f)
          words[word] = word_value
        end
      end
      @top_words[category] = words
    end



  end

  # Public: Predicts category.
  #
  # tokens - A list of tokens (words).
  #
  # Returns a category.
  def predict(tokens)
    # Always predict astronomy, for now.
    # :astronomy
    book_data = Hash.new(0)

    width = tokens.length/20
    new_tokens = tokens[0..width] + 
    tokens[(tokens.length/2 - width)..(tokens.length/2 + width)]

    new_tokens.each do |word|
      book_data[word] += 1 if good_token?(word)
    end

    predicted_category = nil
    most_words = 0

    @top_words.each do |category, words|
      word_keys = words.keys
      current_words = 0

      book_data.each do |word, count|
        if word_keys.include?(word)
          current_words += count
        end
      end

      if current_words > most_words
        most_words = current_words
        predicted_category = category
      end
    end

    predicted_category
  end
end

