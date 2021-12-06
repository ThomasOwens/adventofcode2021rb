# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_six'

class LanternfishSchoolTest < MiniTest::Test
  def setup
    @school = LanternfishSchool.new
  end

  def test_school_starts_empty
    assert_equal(0, @school.school_size)
  end

  def test_add_one_fish
    @school.add_fish(5)
    assert_equal(1, @school.school_size)
  end

  def test_age_fish_without_births
    @school.add_fish(4)
    @school.age
    assert_equal(1, @school.school_size)
  end

  def test_aging_with_birth
    @school.add_fish(0)
    @school.age
    assert_equal(2, @school.school_size)
  end

  def test_part_one_example
    @school.add_fish(3)
    @school.add_fish(4)
    @school.add_fish(3)
    @school.add_fish(1)
    @school.add_fish(2)

    @school.age # After 1 day
    assert_equal(5, @school.school_size)

    @school.age # After 2 days
    assert_equal(6, @school.school_size)
    
    @school.age # After 3 days
    assert_equal(7, @school.school_size)

    @school.age # After 4 days
    assert_equal(9, @school.school_size)

    @school.age # After 5 days
    assert_equal(10, @school.school_size)
    
    @school.age # After 6 days
    assert_equal(10, @school.school_size)
    
    @school.age # After 7 days
    assert_equal(10, @school.school_size)
    
    @school.age # After 8 days
    assert_equal(10, @school.school_size)
    
    @school.age # After 9 days
    assert_equal(11, @school.school_size)

    @school.age # After 10 days
    assert_equal(12, @school.school_size)
    
    @school.age # After 11 days
    assert_equal(15, @school.school_size)
    
    @school.age # After 12 days
    assert_equal(17, @school.school_size)
    
    @school.age # After 13 days
    assert_equal(19, @school.school_size)
    
    @school.age # After 14 days
    assert_equal(20, @school.school_size)
    
    @school.age # After 15 days
    assert_equal(20, @school.school_size)
    
    @school.age # After 16 days
    assert_equal(21, @school.school_size)
    
    @school.age # After 17 days
    assert_equal(22, @school.school_size)

    @school.age # After 18 days
    assert_equal(26, @school.school_size)
  end

  def test_looping
    @school.add_fish(3)
    @school.add_fish(4)
    @school.add_fish(3)
    @school.add_fish(1)
    @school.add_fish(2)

    Array.new(18).collect { @school.age }
    assert_equal(26, @school.school_size)
  end

  def test_part_two_example
    @school.add_fish(3)
    @school.add_fish(4)
    @school.add_fish(3)
    @school.add_fish(1)
    @school.add_fish(2)

    Array.new(256).collect { @school.age }
    assert_equal(26984457539, @school.school_size)
  end
end
