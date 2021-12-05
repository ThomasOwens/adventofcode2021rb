# frozen_string_literal: true

# https://adventofcode.com/2021/day/4

class Board
  attr_reader :score

  def initialize(board_lines)
    @board = []
    board_lines.each do |line|
      @board.push(line)
    end

    @score = 0
  end

  def mark(called_number)
    @board.each do |row| 
      row.each_with_index do |_number, index|
        row[index] = nil if row[index] == called_number
      end
    end

    @score = remaining_value * called_number if winner?
  end

  def winner?
    @board.each { |row| return true if row.all?(&:nil?) }

    @board.transpose.each { |column| return true if column.all?(&:nil?) }

    false
  end

  private

    def remaining_value
      @board.flatten.compact.sum
    end
end

class Game
  attr_reader :winning_boards

  def initialize(numbers, boards)
    @numbers = numbers
    @boards = boards
    @winning_boards = []
  end

  def call_number
    last_called_number = @numbers.shift

    @boards.each { |board| board.mark(last_called_number) }
    @winning_boards.push(*@boards.select(&:winner?))
    @boards.reject!(&:winner?)

    last_called_number
  end

  def winning_boards?
    @winning_boards.any?
  end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])

  numbers = input_file.readline.strip.split(',').map(&:to_i)
  
  board_blocks = input_file.readlines.map(&:strip).delete_if do |line|
    line.strip.empty?
  end.map(&:split).enum_for(:each_slice, 5).to_a
  board_blocks.each { |board| board.each { |row| row.map!(&:to_i) } }

  boards = []
  board_blocks.each { |board_block| boards.push(Board.new(board_block)) }

  game = Game.new(numbers, boards)
  while game.call_number
    # Waiting for nil
  end

  pp "Part One: #{game.winning_boards.first.score}" # Expected 35711
  pp "Part Two: #{game.winning_boards.last.score}" # Expected 5586
end
