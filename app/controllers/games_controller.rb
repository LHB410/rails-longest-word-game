require 'open-uri'
class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @seperated = @letters.join(' ')
  end

  def score
    @user_guess = params[:answer]
    @guess_letters = params[:letters]
    @final_message = score_and_message(@user_guess, @guess_letters)

  end

  def included?(guess, letters)
    guess.chars.all? { |letter| guess.upcase.count(letter) <= letters.count(letter) }
  end

  def score_and_message(attempt, grid)
    if included?(attempt, grid)
      if english_word?(attempt)
        "Well done"
      else
        "Not an english word"
      end
      else
        "Not in the grid"
      end
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end


end
