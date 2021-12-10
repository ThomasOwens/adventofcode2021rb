# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_ten'

class NavigationSubsystemTest < MiniTest::Test
  def setup
    @navigation_subsystem = NavigationSubsystem.new([
                                                      '[({(<(())[]>[[{[]{<()<>>', # Incomplete
                                                      '[(()[<>])]({[<{<<[]>>(',   # Incomplete
                                                      '{([(<{}[<>[]}>{[]{[(<()>', # Expected ], but found } instead.
                                                      '(((({<>}<{<{<>}{[]{[]{}',  # Incomplete
                                                      '[[<[([]))<([[{}[[()]]]',   # Expected ], but found ) instead.
                                                      '[{[{({}]{}}([{[{{{}}([]',  # Expected ), but found ] instead.
                                                      '{<[[]]>}<{[{[{[]{()[[[]',  # Incomplete
                                                      '[<(<(<(<{}))><([]([]()',   # Expected >, but found ) instead.
                                                      '<{([([[(<>()){}]>(<<{{',   # Expected ], but found > instead.
                                                      '<{([{{}}[<[[[<>{}]]]>[]]'  # Incomplete
                                                    ])
  end

  def test_find_corrupted_lines
    corrupted_lines = @navigation_subsystem.corrupted_lines

    assert_equal(5, corrupted_lines.length)
    assert_includes(corrupted_lines, '{([(<{}[<>[]}>{[]{[(<()>')
    assert_includes(corrupted_lines, '[[<[([]))<([[{}[[()]]]')
    assert_includes(corrupted_lines, '[{[{({}]{}}([{[{{{}}([]')
    assert_includes(corrupted_lines, '[<(<(<(<{}))><([]([]()')
    assert_includes(corrupted_lines, '<{([([[(<>()){}]>(<<{{')
  end

  def test_score_corrupted_lines
    assert_equal(26397, @navigation_subsystem.score_corruption)
  end
end
