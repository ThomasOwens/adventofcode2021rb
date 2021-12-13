# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_thirteen'

class GridTest < MiniTest::Test
  def setup
    @grid = Grid.new

    @grid.add_point(6, 10)
    @grid.add_point(0, 14)
    @grid.add_point(9, 10)
    @grid.add_point(0, 3)
    @grid.add_point(10, 4)
    @grid.add_point(4, 11)
    @grid.add_point(6, 0)
    @grid.add_point(6, 12)
    @grid.add_point(4, 1)
    @grid.add_point(0, 13)
    @grid.add_point(10, 12)
    @grid.add_point(3, 4)
    @grid.add_point(3, 0)
    @grid.add_point(8, 4)
    @grid.add_point(1, 10)
    @grid.add_point(2, 14)
    @grid.add_point(8, 10)
    @grid.add_point(9, 0)
  end

  def test_fold
    @grid.fold_y(7)
    assert_equal(17, @grid.points.length)
    assert_includes(@grid.points, [0, 0])
    assert_includes(@grid.points, [2, 0])
    assert_includes(@grid.points, [3, 0])
    assert_includes(@grid.points, [6, 0])
    assert_includes(@grid.points, [9, 0])
    assert_includes(@grid.points, [0, 1])
    assert_includes(@grid.points, [4, 1])
    assert_includes(@grid.points, [6, 2])
    assert_includes(@grid.points, [10, 2])
    assert_includes(@grid.points, [0, 3])
    assert_includes(@grid.points, [4, 3])
    assert_includes(@grid.points, [1, 4])
    assert_includes(@grid.points, [3, 4])
    assert_includes(@grid.points, [6, 4])
    assert_includes(@grid.points, [8, 4])
    assert_includes(@grid.points, [9, 4])
    assert_includes(@grid.points, [10, 4])

    @grid.fold_x(5)
    assert_equal(16, @grid.points.length)
    assert_includes(@grid.points, [0, 0])
    assert_includes(@grid.points, [1, 0])
    assert_includes(@grid.points, [2, 0])
    assert_includes(@grid.points, [3, 0])
    assert_includes(@grid.points, [4, 0])
    assert_includes(@grid.points, [0, 1])
    assert_includes(@grid.points, [4, 1])
    assert_includes(@grid.points, [0, 2])
    assert_includes(@grid.points, [4, 2])
    assert_includes(@grid.points, [0, 3])
    assert_includes(@grid.points, [4, 3])
    assert_includes(@grid.points, [0, 4])
    assert_includes(@grid.points, [1, 4])
    assert_includes(@grid.points, [2, 4])
    assert_includes(@grid.points, [3, 4])
    assert_includes(@grid.points, [4, 4])

    @grid.grid_array.each do |row|
      row.each do |cell|
        print cell
      end
      print "\n"
    end
  end
end
