class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @pickword = word.dup
    @arr =[]
    @str = ""
  end
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def guess a
    index = 0
    raise ArgumentError if a.nil? or a.match(/\W/) or a.empty?
    return false if !(a.match(/[a-z]/))

    if /#{a}/ =~ @word
      @guesses = a
      @str = @arr.push(a).join

    else
      @wrong_guesses = a
      @str = @arr.push(a).join
    end

  end

  def word_with_guesses
    index = 0
    while  index < @word.length
      if !(@word[index].match(/[#{@str}]/))
        @word.sub!(@word[index],"-")
      end
      index +=1
    end
    @word
  end

  def check_win_or_lose
    return :lose if @str.length >= 7 
    return :win  if word_with_guesses == @pickword
    :play
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
