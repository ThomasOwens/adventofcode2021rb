# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_four'

class BoardTest < MiniTest::Test
  def setup
    @board = Board.new([[22, 13, 17, 11, 0],
                        [8, 2, 23, 4, 24],
                        [21, 9, 14, 16, 7],
                        [6, 10, 3, 18, 5],
                        [1, 12, 20, 15, 19]])
  end

  def test_can_initialize_board
    refute_nil(@board)
  end

  def test_can_mark_number
    assert_silent { @board.mark(22) }
  end

  def test_no_winner_no_marked_numbers
    refute(@board.winner?)
  end

  def test_no_winner_with_marked_numbers
    @board.mark(21)
    @board.mark(9)
    @board.mark(14)
    refute(@board.winner?)
  end

  def test_horizontal_win
    @board.mark(21)
    @board.mark(9)
    @board.mark(14)
    @board.mark(16)
    @board.mark(7)
    assert(@board.winner?)
  end

  def test_vertical_win
    @board.mark(13)
    @board.mark(2)
    @board.mark(9)
    @board.mark(10)
    @board.mark(12)

    assert(@board.winner?)
  end
end

class GameTest < MiniTest::Test
  def setup
    @numbers = [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24, 10, 16, 13, 6, 15, 25, 12, 22, 18, 20,
                8, 19, 3, 26, 1]

    @board_one = Board.new([[22, 13, 17, 11, 0],
                            [8, 2, 23, 4, 24],
                            [21, 9, 14, 16, 7],
                            [6, 10, 3, 18, 5],
                            [1, 12, 20, 15, 19]])

    @board_two = Board.new([[3, 15, 0, 2, 22],
                            [9, 18, 13, 17, 5],
                            [19, 8, 7, 25, 23],
                            [20, 11, 10, 24, 4],
                            [14, 21, 16, 12, 6]])

    @board_three = Board.new([[14, 21, 17, 24, 4],
                              [10, 16, 15, 9, 19],
                              [18, 8, 23, 26, 20],
                              [22, 11, 13, 6, 5],
                              [2, 0, 12, 3, 7]])

    @game = Game.new(@numbers, [@board_one, @board_two, @board_three])
  end

  def test_part_one_example
    @game.call_number # 7 called
    refute(@game.winning_boards?)

    @game.call_number # 4 called
    refute(@game.winning_boards?)

    @game.call_number # 9 called
    refute(@game.winning_boards?)

    @game.call_number # 5 called
    refute(@game.winning_boards?)

    @game.call_number # 11 called
    refute(@game.winning_boards?)

    @game.call_number # 17 called
    refute(@game.winning_boards?)

    @game.call_number # 23 called
    refute(@game.winning_boards?)

    @game.call_number # 2 called
    refute(@game.winning_boards?)

    @game.call_number # 0 called
    refute(@game.winning_boards?)

    @game.call_number # 14 called
    refute(@game.winning_boards?)

    @game.call_number # 21 called
    refute(@game.winning_boards?)

    @game.call_number # 24 called
    assert(@game.winning_boards?)

    assert_equal(4512, @game.winning_boards[0].score)
  end
end
