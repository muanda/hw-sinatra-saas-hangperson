class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    #initialize instance variables
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_save = word.dup
    @arr =[]
    @str = ''
  end
  # create getters and setters
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word

  def guess a
    raise ArgumentError if invalid_guess? a
    return false if !(a.match(/[a-z]/)) || @str.match(a)

    if /#{a}/ =~ @word #test the input a if match the word
      @guesses = a
    else
      @wrong_guesses = a
    end

    @str = @arr.push(a).join
  end

  def word_with_guesses
    index = 0
    while  index < @word.length
      unless (@word[index].match(/[#{@str}]/))  # test each char in word if does notmatch the str
        @word.sub!(@word[index],"-") # sub with "-" if does not match
      end
      index +=1
    end
    @word
  end

  def check_win_or_lose
    return :lose if @str.length >= 7
    return :win  if word_with_guesses == @word_save
    :play
  end

  def invalid_guess?(a)
    a.nil? || a.match(/\W/) || a.empty?
  end


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
