# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'display_messages'

# This class controls game flow
class Game
  include DisplayMessages

  AVAILABLE_COLORS = %w[P G Y B O R].freeze

  attr_reader :computer, :human, :board
  attr_accessor :guess_count, :code_breaker, :code_maker

  def initialize
    @board = Board.new
    @computer = Player.new
    @human = Player.new
    @code_maker = nil
    @code_breaker = nil
    @guess_count = 1
  end

  def choose_which_player
    puts "Would you like to be the code-maker? \n
          Y/N"

    case gets.chomp.upcase
    when 'Y'
      computer_as_guesser
    when 'N'
      human_as_guesser
    else
      puts 'Invalid response...'
      choose_which_player
    end
  end

  def computer_as_guesser
    @code_maker = @human
    @code_breaker = @computer
    human.code_selection = create_secret_code
    board.display_board
    until @guess_count > 12
      computer.code_guess = solicit_computer_guess
      single_round
      break if code_cracked?

      @guess_count += 1
      human.score += 1
    end
    game_over(human)
  end

  def human_as_guesser
    @code_maker = @computer
    @code_breaker = @human
    computer.code_selection = compute_secret_code
    board.display_board
    until @guess_count > 12
      human.code_guess = solicit_human_guess
      single_round
      break if code_cracked?

      @guess_count += 1
      computer.score += 1
    end
    game_over(computer)
  end

  private

  def create_secret_code
    puts secret_code_instructions
    input = gets.chomp.upcase.split('')
    if board.choice?(input)
      input
    else
      puts error_message
      create_secret_code
    end
  end

  def compute_secret_code
    puts 'Computer is creating its secret code...'
    AVAILABLE_COLORS.sample(4)
  end

  def solicit_computer_guess
    puts 'Computer is making a guess...'
    computer.code_guess = AVAILABLE_COLORS.sample(4)
  end

  def solicit_human_guess
    puts 'What is your 4-letter guess?'
    input = gets.chomp.upcase.split('')
    if board.choice?(input)
      input
    else
      puts error_message
      solicit_human_guess
    end
  end

  def single_round
    index = @guess_count - 1
    board.display_guess(index, code_breaker.code_guess.join(' | '))
    board.display_board
    evaluate_guess
    display_feedback
  end

  def evaluate_guess
    @index_matches = 0
    @color_matches = 0
    @remaining = [0, 1, 2, 3]
    compare_with_index
  end

  def compare_with_index
    code_maker.code_selection.each_with_index do |color, index|
      if code_breaker.code_guess[index] == color
        @index_matches += 1
        @remaining -= [index]
      elsif compare_colors(color) && colors_remaining(color)
        @color_matches += 1
      end
    end
    @index_matches
  end

  def compare_colors(color)
    code_breaker.code_guess.include?(color)
  end

  def colors_remaining(color)
    @remaining.include?(code_breaker.code_guess.index(color))
  end

  def display_feedback
    puts "Guess #{@guess_count}: #{@index_matches} color(s) in right place and #{@color_matches} correct
    color(s)."
  end

  def code_cracked?
    code_breaker.code_guess.eql?(code_maker.code_selection)
  end

  def game_over(player)
    if code_cracked?
      puts victory
    else
      puts out_of_guesses
      player.score += 1
    end
    puts "The code-maker scored #{player.score} points."
  end
end
