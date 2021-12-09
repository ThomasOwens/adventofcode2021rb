# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_eight'

class SevenSegmentDisplayTest < MiniTest::Test
  def test_part_two_example_one
    display = SevenSegmentDisplay.new(%w[acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab], 
                                      %w[cdfeb fcadb cdfeb cdbaf])
    
    assert_equal(%w[c a g e d b].sort, display.mapping[0])
    assert_equal(%w[a b].sort, display.mapping[1])
    assert_equal(%w[g c d f a].sort, display.mapping[2])
    assert_equal(%w[f b c a d].sort, display.mapping[3])
    assert_equal(%w[e a f b].sort, display.mapping[4])
    assert_equal(%w[c d f b e].sort, display.mapping[5])
    assert_equal(%w[c d f g e b].sort, display.mapping[6])
    assert_equal(%w[d a b].sort, display.mapping[7])
    assert_equal(%w[a c e d g f b].sort, display.mapping[8])
    assert_equal(%w[c e f a b d].sort, display.mapping[9])

    assert_equal(5353, display.output_value)
  end

  def test_part_two_example_two
    output1 = SevenSegmentDisplay.new(%w[be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb], 
                                      %w[fdgacbe cefdb cefbgd gcbe]).output_value
    output2 = SevenSegmentDisplay.new(%w[edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec], 
                                      %w[fcgedb cgb dgebacf gc]).output_value
    output3 = SevenSegmentDisplay.new(%w[fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef], 
                                      %w[cg cg fdcagb cbg]).output_value
    output4 = SevenSegmentDisplay.new(%w[fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega], 
                                      %w[efabcd cedba gadfec cb]).output_value
    output5 = SevenSegmentDisplay.new(%w[aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga], 
                                      %w[gecf egdcabf bgf bfgea]).output_value
    output6 = SevenSegmentDisplay.new(%w[fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf], 
                                      %w[gebdcfa ecba ca fadegcb]).output_value
    output7 = SevenSegmentDisplay.new(%w[dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf], 
                                      %w[cefg dcbef fcge gbcadfe]).output_value
    output8 = SevenSegmentDisplay.new(%w[bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd], 
                                      %w[ed bcgafe cdgba cbgef]).output_value
    output9 = SevenSegmentDisplay.new(%w[egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg], 
                                      %w[gbdfcae bgc cg cgb]).output_value
    output0 = SevenSegmentDisplay.new(%w[gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc], 
                                      %w[fgae cfgab fg bagce]).output_value

    assert_equal(8394, output1)
    assert_equal(9781, output2)
    assert_equal(1197, output3)
    assert_equal(9361, output4)
    assert_equal(4873, output5)
    assert_equal(8418, output6)
    assert_equal(4548, output7)
    assert_equal(1625, output8)
    assert_equal(8717, output9)
    assert_equal(4315, output0)
    assert_equal(61229, 
                 output1 + output2 + output3 + output4 + output5 + output6 + output7 + output8 + output9 + output0)
  end
end
