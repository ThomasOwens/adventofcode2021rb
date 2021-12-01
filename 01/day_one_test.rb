require 'minitest/autorun'
require_relative 'day_one'

class SonarReportTest < Minitest::Test
  def test_can_initialize_sonar_report
    sonar_report = SonarReport.new([1, 2, 3])
    refute(sonar_report.nil?)
  end

  def test_part_one_example
    sonar_report = SonarReport.new([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert_equal(sonar_report.increases, 7)
  end

  def test_part_two_example
    sonar_report = SonarReport.new([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    assert_equal(sonar_report.window_increases(3), 5)
  end
end