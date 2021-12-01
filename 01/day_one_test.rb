# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_one'

class SonarReportTest < Minitest::Test
  def test_can_initialize_sonar_report
    sonar_report = SonarReport.new([1, 2, 3])
    refute_nil(sonar_report)
  end

  def test_part_one_example
    sonar_report = SonarReport.new([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert_equal(7, sonar_report.increases)
  end

  def test_part_two_example
    sonar_report = SonarReport.new([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert_equal(5, sonar_report.window_increases(3))
  end
end
