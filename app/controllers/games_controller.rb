require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = params[:letters]
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    word_letters = @word.upcase.chars
    @word_valid = word_letters.all? { |letter| @letters.include?(letter) }
    @english_word = english_word?(@word)
    @message = message(@word, @letters, @word_valid)

  end
  private
  def english_word?(word)
    response = URI.parse("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def message(word, letters, word_valid)
    if !word_valid
      return "Sorry but #{word} can't be build out of #{letters}"
    elsif english_word?(word)
      return "Congratulations! #{word} is a valid English word!"
    else
      return "Sorry but #{word} does not seem to be a valid English word..."
    end
  end
end
