# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_five'

class HydrothermalVentTest < MiniTest::Test
  def test_horizontal
    vent = HydrothermalVent.new(7, 7, 10, 7)
    assert(vent.horizontal?)
    refute(vent.vertical?)
    refute(vent.diagonal?)
  end

  def test_vertical
    vent = HydrothermalVent.new(10, 6, 10, 11)
    assert(vent.vertical?)
    refute(vent.horizontal?)
    refute(vent.diagonal?)
  end

  def test_diagonal
    vent = HydrothermalVent.new(9, 5, 28, 16)
    assert(vent.diagonal?)
    refute(vent.vertical?)
    refute(vent.horizontal?)
  end

  def test_horizontal_points
    assert_equal([[7, 7], [8, 7], [9, 7], [10, 7]], HydrothermalVent.new(7, 7, 10, 7).points)
  end

  def test_reverse_horizontal_points
    assert_equal([[7, 7], [8, 7], [9, 7], [10, 7]], HydrothermalVent.new(10, 7, 7, 7).points)
  end

  def test_vertical_points
    assert_equal([[10, 6], [10, 7], [10, 8], [10, 9], [10, 10], [10, 11]], HydrothermalVent.new(10, 6, 10, 11).points)
  end

  def test_reverse_vertical_points
    assert_equal([[10, 6], [10, 7], [10, 8], [10, 9], [10, 10], [10, 11]], HydrothermalVent.new(10, 11, 10, 6).points)
  end
end

class OceanFloorTest < MiniTest::Test
  def setup
    @ocean_floor = OceanFloor.new
  end

  def test_add_vent
    @ocean_floor.add_vent(HydrothermalVent.new(2, 2, 2, 1))
    assert_equal(2, @ocean_floor.vent_points.size)
    assert_equal(0, @ocean_floor.dangerous_vent_points.size)
  end

  def test_part_one_example
    @ocean_floor.add_vent(HydrothermalVent.new(0, 9, 5, 9))
    @ocean_floor.add_vent(HydrothermalVent.new(8, 0, 0, 8))
    @ocean_floor.add_vent(HydrothermalVent.new(9, 4, 3, 4))
    @ocean_floor.add_vent(HydrothermalVent.new(2, 2, 2, 1))
    @ocean_floor.add_vent(HydrothermalVent.new(7, 0, 7, 4))
    @ocean_floor.add_vent(HydrothermalVent.new(6, 4, 2, 0))
    @ocean_floor.add_vent(HydrothermalVent.new(0, 9, 2, 9))
    @ocean_floor.add_vent(HydrothermalVent.new(3, 4, 1, 4))
    @ocean_floor.add_vent(HydrothermalVent.new(0, 0, 8, 8))
    @ocean_floor.add_vent(HydrothermalVent.new(5, 5, 8, 2))

    assert_equal(5, @ocean_floor.dangerous_vent_points.size)
  end
end
