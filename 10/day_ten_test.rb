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
    assert_includes(corrupted_lines.keys, '{([(<{}[<>[]}>{[]{[(<()>')
    assert_includes(corrupted_lines.keys, '[[<[([]))<([[{}[[()]]]')
    assert_includes(corrupted_lines.keys, '[{[{({}]{}}([{[{{{}}([]')
    assert_includes(corrupted_lines.keys, '[<(<(<(<{}))><([]([]()')
    assert_includes(corrupted_lines.keys, '<{([([[(<>()){}]>(<<{{')
  end

  def test_score_corrupted_lines
    assert_equal(26397, @navigation_subsystem.score_corruption)
  end

  def test_find_incomplete_lines
    incomplete_lines = @navigation_subsystem.incomplete_lines

    assert_equal(5, incomplete_lines.length)
    assert_includes(incomplete_lines.keys, '[({(<(())[]>[[{[]{<()<>>')
    assert_includes(incomplete_lines.keys, '[(()[<>])]({[<{<<[]>>(')
    assert_includes(incomplete_lines.keys, '(((({<>}<{<{<>}{[]{[]{}')
    assert_includes(incomplete_lines.keys, '{<[[]]>}<{[{[{[]{()[[[]')
    assert_includes(incomplete_lines.keys, '<{([{{}}[<[[[<>{}]]]>[]]')
    assert_equal('}}]])})]', incomplete_lines['[({(<(())[]>[[{[]{<()<>>'])
    assert_equal(')}>]})', incomplete_lines['[(()[<>])]({[<{<<[]>>('])
    assert_equal('}}>}>))))', incomplete_lines['(((({<>}<{<{<>}{[]{[]{}'])
    assert_equal(']]}}]}]}>', incomplete_lines['{<[[]]>}<{[{[{[]{()[[[]'])
    assert_equal('])}>', incomplete_lines['<{([{{}}[<[[[<>{}]]]>[]]'])
  end

  def test_score_completions
    scores = @navigation_subsystem.score_completions

    assert_equal(5, scores.length)
    assert_equal(288957, scores['}}]])})]'])
    assert_equal(5566, scores[')}>]})'])
    assert_equal(1480781, scores['}}>}>))))'])
    assert_equal(995444, scores[']]}}]}]}>'])
    assert_equal(294, scores['])}>'])
  end

  def test_finding_winning_score
    scores = @navigation_subsystem.score_completions

    pp scores.values.sort.reverse

    assert_equal(288957, scores.values.sort.reverse[scores.length / 2])
  end
end
