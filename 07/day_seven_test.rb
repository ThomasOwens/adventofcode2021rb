# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_seven'

class CrabmarineFleetTest < MiniTest::Test
  def test_no_movement
    fleet = CrabmarineFleet.new([3])
    assert_equal(0, fleet.fuel_to_move_to(3))
  end

  def test_move_forward
    fleet = CrabmarineFleet.new([1])
    assert_equal(10, fleet.fuel_to_move_to(5))
  end

  def test_move_backward
    fleet = CrabmarineFleet.new([7])
    assert_equal(3, fleet.fuel_to_move_to(5))
  end

  def test_move_a_fleet
    fleet = CrabmarineFleet.new([16, 1, 2, 0, 4, 2, 7, 1, 2, 14])

    assert_equal(206, fleet.fuel_to_move_to(2))
    assert_equal(168, fleet.fuel_to_move_to(5))
  end

  def test_fuel_to_align
    fleet = CrabmarineFleet.new([16, 1, 2, 0, 4, 2, 7, 1, 2, 14])

    assert_equal(5, fleet.fuel_to_align(0, 16).keys.first)
  end
end
