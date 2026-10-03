class WordGuesserGame
  # lets tests read/write @word, @guesses, @wrong_guesses
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''        # correct letters guessed
    @wrong_guesses = ''  # wrong letters guessed
  end

  # returns true for a new guess, false for a repeat
  def guess(letter)
    # nil, empty, or non-letter -> error
    raise ArgumentError if letter.nil? || letter !~ /\A[a-zA-Z]\z/
    letter = letter.downcase
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.downcase.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    true
  end

  # e.g. word 'banana', guesses 'bn' -> 'b-n-n-'
  def word_with_guesses
    @word.chars.map { |c| @guesses.include?(c.downcase) ? c : '-' }.join
  end

  def check_win_or_lose
    return :play if @word.empty?
    return :lose if @wrong_guesses.length >= 7
    return :win if @word.chars.all? { |c| @guesses.include?(c.downcase) }
    :play
  end

  # Get a word from remote "random word" service
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://esaas-randomword-27a759b6224d.herokuapp.com/RandomWord')
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      return http.post(uri, "").body
    end
  end
end
