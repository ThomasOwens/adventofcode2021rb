# frozen_string_literal: true

#######################################################################################################################
# --- Day 4: Giant Squid ---
#
# --- Part One ---
# You're already almost 1.5km (almost a mile) below the surface of the ocean, already so deep that you can't see any
# sunlight. What you can see, however, is a giant squid that has attached itself to the outside of your submarine.
#
# Maybe it wants to play bingo?
#
# Bingo is played on a set of boards each consisting of a 5x5 grid of numbers. Numbers are chosen at random, and the
# chosen number is marked on all boards on which it appears. (Numbers may not appear on all boards.) If all numbers in
# any row or any column of a board are marked, that board wins. (Diagonals don't count.)
#
# The submarine has a bingo subsystem to help passengers (currently, you and the giant squid) pass the time. It
# automatically generates a random order in which to draw numbers and a random set of boards (your puzzle input). For
# example:
#
# 7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1
#
# 22 13 17 11  0
#  8  2 23  4 24
# 21  9 14 16  7
#  6 10  3 18  5
#  1 12 20 15 19
#
#  3 15  0  2 22
#  9 18 13 17  5
# 19  8  7 25 23
# 20 11 10 24  4
# 14 21 16 12  6
#
# 14 21 17 24  4
# 10 16 15  9 19
# 18  8 23 26 20
# 22 11 13  6  5
#  2  0 12  3  7
#
# After the first five numbers are drawn (7, 4, 9, 5, and 11), there are no winners
#
# After the next six numbers are drawn (17, 23, 2, 0, 14, and 21), there are still no winners.
#
# Finally, 24 is drawn.
#
# At this point, the third board wins because it has at least one complete row or column of marked numbers (in this
# case, the entire top row is marked: 14 21 17 24 4).
#
# The score of the winning board can now be calculated. Start by finding the sum of all unmarked numbers on that board;
# in this case, the sum is 188. Then, multiply that sum by the number that was just called when the board won, 24, to
# get the final score, 188 * 24 = 4512.
#
# To guarantee victory against the giant squid, figure out which board will win first. What will your final score be if
# you choose that board?
#######################################################################################################################

class Board
  def initialize(board_lines)
    @board = []

    board_lines.each do |line|
      @board.push(line)
    end
  end

  def mark(called_number)
    @board.each do |row| 
      row.each_with_index do |_number, index|
        row[index] = nil if row[index] == called_number
      end
    end
  end

  def winner?
    @board.each { |row| return true if row.all?(&:nil?) }

    @board.transpose.each { |column| return true if column.all?(&:nil?) }

    false
  end

  def remaining_value
    @board.flatten.compact.sum(&:to_i)
  end
end

class Game
  attr_reader :last_called_number

  def initialize(numbers, boards)
    @numbers = numbers
    @boards = boards
    @last_called_number = 0
  end

  def call_number
    @last_called_number = @numbers.shift

    @boards.each { |board| board.mark(@last_called_number) }
  end

  def winning_boards?
    @boards.count(&:winner?).positive?
  end

  def winning_boards
    @boards.select(&:winner?)
  end

  def score
    winning_boards[0].remaining_value * @last_called_number.to_i
  end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])

  numbers = input_file.readline.strip.split(',')
  
  board_blocks = input_file.readlines.map(&:strip).delete_if do |line|
    line.strip.empty?
  end.map(&:split).enum_for(:each_slice, 5).to_a

  boards = []
  board_blocks.each { |board_block| boards.push(Board.new(board_block)) }

  game = Game.new(numbers, boards)
  loop do
    game.call_number
    break if game.winning_boards?
  end

  pp "Part One: #{game.score}" # Expected 35711
end
