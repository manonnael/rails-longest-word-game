require 'open-uri'

class GamesController < ApplicationController
  def new
    # servira à afficher une nouvelle grille aléatoire et un formulaire. Le formulaire sera envoyé (avec POST) à l’action score.
    # @letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'].shuffle.first(10)
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    json = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    hash = JSON.parse(json)

    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) } && hash['found'] == true
      @score = "Congratulations! #{@word} is a valid english word."
    elsif hash['found'] == false
      @score = "Sorry but #{@word} does not seem to be a valid english word"
    else
      @score = "Sorry but #{@word} cannot be built out of #{@letters}"
    end
  end
end
