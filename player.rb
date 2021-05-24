# frozen_string_literal: true

# This class sets up the players
class Player
  attr_accessor :score, :code_guess, :code_selection

  def initialize
    @score = 0
    @code_selection = []
    @code_guess = []
  end
end
