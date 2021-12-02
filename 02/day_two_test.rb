# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_two'

class SubmarineTest < Minitest::Test
  def setup
    @submarine = Submarine.new
  end

  def test_can_initialize_submarine
    refute_nil(@submarine)
    assert_equal(0, @submarine.horizontal_position)
    assert_equal(0, @submarine.depth)
  end

  def test_can_move_forward
    @submarine.move(%w[forward 1])
    assert_equal(1, @submarine.horizontal_position)
  end

  def test_can_move_up_and_down
    @submarine.move(%w[down 5])
    assert_equal(5, @submarine.depth)

    @submarine.move(%w[up 3])
    assert_equal(2, @submarine.depth)
  end

  def test_part_one_example
    @submarine.move(%w[forward 5])
    @submarine.move(%w[down 5])
    @submarine.move(%w[forward 8])
    @submarine.move(%w[up 3])
    @submarine.move(%w[down 8])
    @submarine.move(%w[forward 2])
    assert_equal(15, @submarine.horizontal_position)
    assert_equal(10, @submarine.depth)
  end
end

class AimingSubmarineTest < Minitest::Test
  def setup
    @submarine = AimingSubmarine.new
  end

  def test_can_initialize_submarine
    refute_nil(@submarine)
    assert_equal(0, @submarine.aim)
  end

  def test_can_move_forward
    @submarine.move(%w[forward 1])
    assert_equal(1, @submarine.horizontal_position)
  end

  def test_can_aim_up_and_down
    @submarine.move(%w[down 5])
    assert_equal(5, @submarine.aim)

    @submarine.move(%w[up 3])
    assert_equal(2, @submarine.aim)
  end

  def test_part_two_example
    @submarine.move(%w[forward 5])
    @submarine.move(%w[down 5])
    @submarine.move(%w[forward 8])
    @submarine.move(%w[up 3])
    @submarine.move(%w[down 8])
    @submarine.move(%w[forward 2])
    assert_equal(15, @submarine.horizontal_position)
    assert_equal(60, @submarine.depth)
  end
end
