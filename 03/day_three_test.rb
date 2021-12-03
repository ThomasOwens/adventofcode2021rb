# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_three'

class DiagnosticReportTest < Minitest::Test
  def setup
    @diagnostic_report = DiagnosticReport.new
  end

  def test_can_initialize_diagnostic_report
    refute_nil(@diagnostic_report)
  end

  def test_part_one_example
    @diagnostic_report.parse_entry('00100')
    @diagnostic_report.parse_entry('11110')
    @diagnostic_report.parse_entry('10110')
    @diagnostic_report.parse_entry('10111')
    @diagnostic_report.parse_entry('10101')
    @diagnostic_report.parse_entry('01111')
    @diagnostic_report.parse_entry('00111')
    @diagnostic_report.parse_entry('11100')
    @diagnostic_report.parse_entry('10000')
    @diagnostic_report.parse_entry('11001')
    @diagnostic_report.parse_entry('00010')
    @diagnostic_report.parse_entry('01010')

    assert_equal(22, @diagnostic_report.gamma_rate)
    assert_equal(9, @diagnostic_report.epsilon_rate)
  end

  def test_part_two_example
    @diagnostic_report.parse_entry('00100')
    @diagnostic_report.parse_entry('11110')
    @diagnostic_report.parse_entry('10110')
    @diagnostic_report.parse_entry('10111')
    @diagnostic_report.parse_entry('10101')
    @diagnostic_report.parse_entry('01111')
    @diagnostic_report.parse_entry('00111')
    @diagnostic_report.parse_entry('11100')
    @diagnostic_report.parse_entry('10000')
    @diagnostic_report.parse_entry('11001')
    @diagnostic_report.parse_entry('00010')
    @diagnostic_report.parse_entry('01010')

    assert_equal(23, @diagnostic_report.oxygen_generator_rating)
    assert_equal(10, @diagnostic_report.co2_scrubber_rating)
  end

  def test_assert_correct_answers
    File.foreach(File.join(File.dirname(__FILE__), 'day_three_input.txt')) do |line|
      @diagnostic_report.parse_entry(line.chomp)
    end

    assert_equal(3847100, @diagnostic_report.power_consumption)
    assert_equal(4105235, @diagnostic_report.oxygen_generator_rating * @diagnostic_report.co2_scrubber_rating)
  end
end
