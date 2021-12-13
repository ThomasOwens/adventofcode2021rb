# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_twelve'

class CaveSystemTest < MiniTest::Test
  def test_add_tunnel
    cave_system = CaveSystem.new
    
    assert_equal(0, cave_system.size)

    cave_system.add_cave('A')

    assert_equal(1, cave_system.size)
  end

  def test_cave_uniqueness
    cave_system = CaveSystem.new

    assert_equal(0, cave_system.size)

    cave_system.add_cave('a')
    cave_system.add_cave('a')

    assert_equal(1, cave_system.size)
  end

  def test_add_connection_with_new_caves
    cave_system = CaveSystem.new

    assert_equal(0, cave_system.size)

    cave_system.add_tunnel('a', 'b')

    assert_equal(2, cave_system.size)
    assert(cave_system.connected?('a', 'b'))
    assert(cave_system.connected?('b', 'a'))
  end

  def test_add_connection_with_existing_caves
    cave_system = CaveSystem.new

    assert_equal(0, cave_system.size)

    cave_system.add_cave('a')
    
    assert_equal(1, cave_system.size)

    cave_system.add_cave('b')

    assert_equal(2, cave_system.size)

    cave_system.add_tunnel('a', 'b')
    
    assert_equal(2, cave_system.size)
    assert(cave_system.connected?('a', 'b'))
    assert(cave_system.connected?('b', 'a'))
  end

  def test_part_one_rough_map
    cave_system = CaveSystem.new

    cave_system.add_tunnel('start', 'A')
    cave_system.add_tunnel('start', 'b')
    cave_system.add_tunnel('A', 'c')
    cave_system.add_tunnel('A', 'b')
    cave_system.add_tunnel('b', 'd')
    cave_system.add_tunnel('A', 'end')
    cave_system.add_tunnel('b', 'end')

    assert_equal(6, cave_system.size)
    assert(cave_system.connected?('start', 'A'))
    assert(cave_system.connected?('start', 'b'))
    refute(cave_system.connected?('start', 'c'))
    refute(cave_system.connected?('start', 'd'))
    refute(cave_system.connected?('start', 'end'))
    assert(cave_system.connected?('A', 'start'))
    assert(cave_system.connected?('A', 'b'))
    assert(cave_system.connected?('A', 'c'))
    refute(cave_system.connected?('A', 'd'))
    assert(cave_system.connected?('A', 'end'))
    assert(cave_system.connected?('b', 'start'))
    assert(cave_system.connected?('b', 'A'))
    refute(cave_system.connected?('b', 'c'))
    assert(cave_system.connected?('b', 'd'))
    assert(cave_system.connected?('b', 'end'))
    refute(cave_system.connected?('c', 'start'))
    assert(cave_system.connected?('c', 'A'))
    refute(cave_system.connected?('c', 'b'))
    refute(cave_system.connected?('c', 'd'))
    refute(cave_system.connected?('c', 'end'))
    refute(cave_system.connected?('d', 'start'))
    refute(cave_system.connected?('d', 'A'))
    assert(cave_system.connected?('d', 'b'))
    refute(cave_system.connected?('d', 'c'))
    refute(cave_system.connected?('d', 'end'))
  end

  def test_part_one
    cave_system = CaveSystem.new

    cave_system.add_tunnel('start', 'A')
    cave_system.add_tunnel('start', 'b')
    cave_system.add_tunnel('A', 'c')
    cave_system.add_tunnel('A', 'b')
    cave_system.add_tunnel('b', 'd')
    cave_system.add_tunnel('A', 'end')
    cave_system.add_tunnel('b', 'end')

    paths = cave_system.paths('start', 'end', false)
    assert_includes(paths, %w[start A b A c A end])
    assert_includes(paths, %w[start A b A end])
    assert_includes(paths, %w[start A b end])
    assert_includes(paths, %w[start A c A b A end])
    assert_includes(paths, %w[start A c A b end])
    assert_includes(paths, %w[start A c A end])
    assert_includes(paths, %w[start A end])
    assert_includes(paths, %w[start b A c A end])
    assert_includes(paths, %w[start b A end])
    assert_includes(paths, %w[start b end])
  end

  def test_part_two
    cave_system = CaveSystem.new

    cave_system.add_tunnel('start', 'A')
    cave_system.add_tunnel('start', 'b')
    cave_system.add_tunnel('A', 'c')
    cave_system.add_tunnel('A', 'b')
    cave_system.add_tunnel('b', 'd')
    cave_system.add_tunnel('A', 'end')
    cave_system.add_tunnel('b', 'end')

    paths = cave_system.paths('start', 'end', true)
    assert_includes(paths, %w[start A b A b A c A end])
    assert_includes(paths, %w[start A b A b A end])
    assert_includes(paths, %w[start A b A b end])
    assert_includes(paths, %w[start A b A c A b A end])
    assert_includes(paths, %w[start A b A c A b end])
    assert_includes(paths, %w[start A b A c A c A end])
    assert_includes(paths, %w[start A b A c A end])
    assert_includes(paths, %w[start A b A end])
    assert_includes(paths, %w[start A b d b A c A end])
    assert_includes(paths, %w[start A b d b A end])
    assert_includes(paths, %w[start A b d b end])
    assert_includes(paths, %w[start A b end])
    assert_includes(paths, %w[start A c A b A b A end])
    assert_includes(paths, %w[start A c A b A b end])
    assert_includes(paths, %w[start A c A b A c A end])
    assert_includes(paths, %w[start A c A b A end])
    assert_includes(paths, %w[start A c A b d b A end])
    assert_includes(paths, %w[start A c A b d b end])
    assert_includes(paths, %w[start A c A b end])
    assert_includes(paths, %w[start A c A c A b A end])
    assert_includes(paths, %w[start A c A c A b end])
    assert_includes(paths, %w[start A c A c A end])
    assert_includes(paths, %w[start A c A end])
    assert_includes(paths, %w[start A end])
    assert_includes(paths, %w[start b A b A c A end])
    assert_includes(paths, %w[start b A b A,end])
    assert_includes(paths, %w[start b A b end])
    assert_includes(paths, %w[start b A c A b A,end])
    assert_includes(paths, %w[start b A c A b end])
    assert_includes(paths, %w[start b A c A c A end])
    assert_includes(paths, %w[start b A c A end])
    assert_includes(paths, %w[start b A end])
    assert_includes(paths, %w[start b d b A c A end])
    assert_includes(paths, %w[start b d b A end])
    assert_includes(paths, %w[start b d b end])
    assert_includes(paths, %w[start b end])
  end
end
