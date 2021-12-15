# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_fifteen'

class RiskMapTest < MiniTest::Test
  def test_part_one_example
    risk_map_grid = [
      [1, 1, 6, 3, 7, 5, 1, 7, 4, 2],
      [1, 3, 8, 1, 3, 7, 3, 6, 7, 2],
      [2, 1, 3, 6, 5, 1, 1, 3, 2, 8],
      [3, 6, 9, 4, 9, 3, 1, 5, 6, 9],
      [7, 4, 6, 3, 4, 1, 7, 1, 1, 1],
      [1, 3, 1, 9, 1, 2, 8, 1, 3, 7],
      [1, 3, 5, 9, 9, 1, 2, 4, 2, 1],
      [3, 1, 2, 5, 4, 2, 1, 6, 3, 9],
      [1, 2, 9, 3, 1, 3, 8, 5, 2, 1],
      [2, 3, 1, 1, 9, 4, 4, 5, 8, 1]
    ]

    risk_map = RiskMap.new(risk_map_grid)
    best_paths = risk_map.navigate

    assert_equal(40, best_paths.first[1])
  end
end
