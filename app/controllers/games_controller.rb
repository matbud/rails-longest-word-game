require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].split
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)
    
    if !json["found"]
      @result = "#{@word} is not a correct word!"
    elsif !in_grid?(@word, @grid)
      @result = "You cannot make #{@word} from #{@grid.join(" ")}"
    else
      @result = "#{@word} is correct"
    end
  end
end

def in_grid?(attempt, grid)
  attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
end
