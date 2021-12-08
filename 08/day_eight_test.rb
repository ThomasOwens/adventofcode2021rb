# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_eight'

class SevenSegmentDisplayTest < MiniTest::Test
  def setup
    @display = SevenSegmentDisplay.new
  end

  def test_signal_patterns
    test_signal_patterns = %w[acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab]
    test_output_value = %w[cdfeb fcadb cdfeb cdbaf]
    @display.add_entry(test_signal_patterns, test_output_value)

    assert_equal(1, @display.signal_patterns.length)
    assert(@display.signal_patterns.member?(test_signal_patterns))
  end

  def test_output_value
    test_signal_patterns = %w[acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab]
    test_output_value = %w[cdfeb fcadb cdfeb cdbaf]
    @display.add_entry(test_signal_patterns, test_output_value)
  
    assert_equal(1, @display.output_values.length)
    assert(@display.output_values.member?(test_output_value))
  end

  def test_part_one_example
    test_signal_patterns = []
    test_signal_patterns.append(%w[be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb])
    test_signal_patterns.append(%w[edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec])
    test_signal_patterns.append(%w[fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef])
    test_signal_patterns.append(%w[fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega])
    test_signal_patterns.append(%w[aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga])
    test_signal_patterns.append(%w[fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf])
    test_signal_patterns.append(%w[dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf])
    test_signal_patterns.append(%w[bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd])
    test_signal_patterns.append(%w[egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg])
    test_signal_patterns.append(%w[gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc])

    test_output_values = []
    test_output_values.append(%w[fdgacbe cefdb cefbgd gcbe])
    test_output_values.append(%w[fcgedb cgb dgebacf gc])
    test_output_values.append(%w[cg cg fdcagb cbg])
    test_output_values.append(%w[efabcd cedba gadfec cb])
    test_output_values.append(%w[gecf egdcabf bgf bfgea])
    test_output_values.append(%w[gebdcfa ecba ca fadegcb])
    test_output_values.append(%w[cefg dcbef fcge gbcadfe])
    test_output_values.append(%w[ed bcgafe cdgba cbgef])
    test_output_values.append(%w[gbdfcae bgc cg cgb])
    test_output_values.append(%w[fgae cfgab fg bagce])

    (0..test_signal_patterns.length - 1).each do |index|
      @display.add_entry(test_signal_patterns[index], test_output_values[index])
    end    

    output_digits = @display.output_value_digits
    assert_equal(26, output_digits[1] + output_digits[4] + output_digits[7] + output_digits[8])
  end
end
