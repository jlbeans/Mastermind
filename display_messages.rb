# frozen_string_literal: true

# This module stores display messages
module DisplayMessages
  def welcome
    puts "Welcome to Mastermind! \n
    Instructions: The code-maker will choose a 4-color secret code that the
    code-breaker must crack. The code-breaker will have 12 guesses, and after
    each guess feedback will be given about whether there are any correct
    colors and if they are in the correct places. Each guess should be 4
    letters with no spaces or commas. (ex: BGYO).
    Available colors: P(purple), G(green), Y(yellow), B(blue), O(orange), and
    R(red). \n
    Good luck! \n
    ========================================================"
  end

  def secret_code_instructions
    puts "Please enter your 4-letter secret code using no spaces or commas (ex: BGYO). \n
    ========================================================"
  end

  def error_message
    puts "Invalid choice. Please try again using a 4-letter combination of the
    available colors (ex: BGYO).
    ========================================================"
  end

  def victory
    puts "The code-breaker has cracked the secret code!
    Game over! \n
    ========================================================"
  end

  def out_of_guesses
    puts "Uh oh, the code-breaker ran out of guesses!
    Game over! \n
    ========================================================"
  end
end
