# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_seventeen'

class ProbeTest < MiniTest::Test
  def test_part_one_example_one
    initial_x_velocity = 7
    initial_y_velocity = 2
    target_area = [[20, 30], [-10, -5]]

    probe = Probe.new(initial_x_velocity, initial_y_velocity, target_area)

    loop do
      probe.step
      break if probe.in_target_area? || probe.beyond_target_area?
    end

    assert(probe.was_ever_in_target_area?)
  end

  def test_part_one_example_two
    initial_x_velocity = 6
    initial_y_velocity = 3
    target_area = [[20, 30], [-10, -5]]

    probe = Probe.new(initial_x_velocity, initial_y_velocity, target_area)

    loop do
      probe.step
      break if probe.in_target_area? || probe.beyond_target_area?
    end

    assert(probe.was_ever_in_target_area?)
  end

  def test_part_one_example_three
    initial_x_velocity = 9
    initial_y_velocity = 0
    target_area = [[20, 30], [-10, -5]]

    probe = Probe.new(initial_x_velocity, initial_y_velocity, target_area)

    loop do
      probe.step
      break if probe.in_target_area? || probe.beyond_target_area?
    end

    assert(probe.was_ever_in_target_area?)
  end

  def test_part_one_example_four
    initial_x_velocity = 17
    initial_y_velocity = -4
    target_area = [[20, 30], [-10, -5]]

    probe = Probe.new(initial_x_velocity, initial_y_velocity, target_area)

    loop do
      probe.step
      break if probe.in_target_area? || probe.beyond_target_area?
    end
    
    refute(probe.was_ever_in_target_area?)
  end
end
