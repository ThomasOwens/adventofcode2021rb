# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_nine'

class HeightmapTest < MiniTest::Test
  def setup
    map = [
      [2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
      [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
      [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
      [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
      [9, 8, 9, 9, 9, 6, 5, 6, 7, 8]
    ]

    @heightmap = Heightmap.new(map)
  end

  def test_find_low_points
    low_points = @heightmap.low_points

    assert_equal(4, low_points.length)
    assert(low_points.key?([0, 1]))
    assert(low_points.key?([0, 9]))
    assert(low_points.key?([2, 2]))
    assert(low_points.key?([4, 6]))
  end

  def test_find_basins
    found_basins = @heightmap.basins

    assert_equal(4, found_basins.length)

    assert_equal(3, found_basins[[0, 1]].length)
    assert_equal(9, found_basins[[0, 9]].length)
    assert_equal(14, found_basins[[2, 2]].length)
    assert_equal(9, found_basins[[4, 6]].length)
  end

  def test_get_risk_levels
    low_points = @heightmap.low_points

    assert_equal(4, low_points.length)
    assert_equal(low_points.value?(2))
    assert_equal(low_points.value?(1))
    assert_equal(low_points.value?(6)) # Recorded twice.
  end

  def test_total_risk_level
    assert_equal(15, @heightmap.total_risk_level)
  end
end
