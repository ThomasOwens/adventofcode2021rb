# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_seven'

class CrabmarineFleetTest < MiniTest::Test
  def test_no_movement
    fleet = CrabmarineFleet.new([3])
    assert_equal(0, fleet.fuel_to_move_to(3))
  end

  def test_move_forward
    fleet = CrabmarineFleet.new([0])
    assert_equal(2, fleet.fuel_to_move_to(2))
  end

  def test_move_backward
    fleet = CrabmarineFleet.new([7])
    assert_equal(5, fleet.fuel_to_move_to(2))
  end

  def test_move_a_fleet_part_one_example
    fleet = CrabmarineFleet.new([16, 1, 2, 0, 4, 2, 7, 1, 2, 14])

    assert_equal(37, fleet.fuel_to_move_to(2))
    assert_equal(41, fleet.fuel_to_move_to(1))
    assert_equal(39, fleet.fuel_to_move_to(3))
    assert_equal(71, fleet.fuel_to_move_to(10))
  end

  def test_fuel_to_align_part_one_example
    fleet = CrabmarineFleet.new([16, 1, 2, 0, 4, 2, 7, 1, 2, 14])

    assert_equal(2, fleet.fuel_to_align(0, 16).keys.first)
  end
end
