# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_eleven'

class DumboOctopusesTest < MiniTest::Test
  def test_adjacent_flashing
    octopuses = DumboOctopuses.new([
                                     [1, 1, 1, 1, 1],
                                     [1, 9, 9, 9, 1],
                                     [1, 9, 1, 9, 1],
                                     [1, 9, 9, 9, 1],
                                     [1, 1, 1, 1, 1]
                                   ])

    octopuses.step
    assert_equal(9, octopuses.step_flashes[1])

    octopuses.step
    assert_equal(0, octopuses.step_flashes[2])
  end

  def test_part_one_example
    octopuses = DumboOctopuses.new([
                                     [5, 4, 8, 3, 1, 4, 3, 2, 2, 3],
                                     [2, 7, 4, 5, 8, 5, 4, 7, 1, 1],
                                     [5, 2, 6, 4, 5, 5, 6, 1, 7, 3],
                                     [6, 1, 4, 1, 3, 3, 6, 1, 4, 6],
                                     [6, 3, 5, 7, 3, 8, 5, 4, 7, 8],
                                     [4, 1, 6, 7, 5, 2, 4, 6, 4, 5],
                                     [2, 1, 7, 6, 8, 4, 1, 7, 2, 1],
                                     [6, 8, 8, 2, 8, 8, 1, 1, 3, 4],
                                     [4, 8, 4, 6, 8, 4, 8, 5, 5, 4],
                                     [5, 2, 8, 3, 7, 5, 1, 5, 2, 6]
                                   ])

    octopuses.step
    assert_equal(0, octopuses.step_flashes[1])

    octopuses.step
    assert_equal(35, octopuses.step_flashes[2])

    octopuses.step
    assert_equal(45, octopuses.step_flashes[3])

    octopuses.step
    assert_equal(16, octopuses.step_flashes[4])

    octopuses.step
    assert_equal(8, octopuses.step_flashes[5])

    octopuses.step
    assert_equal(1, octopuses.step_flashes[6])

    octopuses.step
    assert_equal(7, octopuses.step_flashes[7])

    octopuses.step
    assert_equal(24, octopuses.step_flashes[8])

    octopuses.step
    assert_equal(39, octopuses.step_flashes[9])

    octopuses.step
    assert_equal(29, octopuses.step_flashes[10])

    assert_equal(204, octopuses.total_flashes)
  end
end
