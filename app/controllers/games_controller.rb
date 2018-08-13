require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = Array.new(8) { ('A'..'Z').to_a.sample }

  end

  def score
    @guess = params[:games].upcase.split("")
    @letters = params[:letters].split(" ")
    guess_in_letters = @guess.all? {|letter| @guess.count(letter) <= @letters.count(letter)}
    if guess_in_letters
      url = "https://wagon-dictionary.herokuapp.com/#{@guess.join}"
      response = open(url)
      json = JSON.parse(response.read)
      # raise
      if json["found"]
        @result = "Congratulations!#{@guess} is a valid english word"
      else
        @result = "Sorry #{@guess} is not an english word"
      end
    else
      @result = "Sorry the #{@guess} can't be build out of #{@letters}"
    end
  end
end
