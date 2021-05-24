# frozen_string_literal: true

# This class sets up the board
class Board
  attr_reader :board

  AVAILABLE_COLORS = %w[P G Y B O R].freeze

  def initialize(board = (1..12).to_a)
    @board = board
  end

  def display_board
    12.times do |i|
      puts " #{@board[i]}  "
      puts '--------------'
    end
  end

  def choice?(input)
    valid_colors?(input) && valid_format?(input)
  end

  def valid_colors?(input)
    input.all? { |color| AVAILABLE_COLORS.include?(color) }
  end

  def valid_format?(input)
    input.length == 4
  end

  def display_guess(index, colors)
    @board[index] = colors
  end
end
