# frozen_string_literal: true

require_relative 'game'

# This class starts/ends the game
class Main
  attr_reader :game

  def initialize
    @game = Game.new
  end

  def start_game
    game.welcome
    game.choose_which_player
    new_game
  end

  def new_game
    puts "Would you like to play again? \n
      Y/N"
    case gets.chomp.upcase
    when 'Y'
      initialize
      start_game
    when 'N'
      puts 'Thanks for playing!'
    else
      puts 'Invalid response...'
      new_game
    end
  end
end

mastermind = Main.new
mastermind.start_game
