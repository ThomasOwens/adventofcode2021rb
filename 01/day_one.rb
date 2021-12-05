# frozen_string_literal: true

# https://adventofcode.com/2021/day/1

class SonarReport
  def initialize(sonar_sweep_report)
    raise ArgumentError, 'Missing sonar sweep report.' if sonar_sweep_report.nil?
    raise ArgumentError, 'Empty sonar sweep report.' if sonar_sweep_report.empty?

    @sonar_sweep_report = sonar_sweep_report
  end

  def increases
    count_increases(@sonar_sweep_report)
  end

  def window_increases(window_size)
    sliding_windows = []
    @sonar_sweep_report.each_cons(window_size) { |window| sliding_windows.push(window.sum) }
    count_increases(sliding_windows)
  end

  private
  
    def count_increases(data)
      increases = 0
      data.each_cons(2) { |readings| increases += 1 if readings[1] > readings[0] }
      increases
    end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  depth_measurements = File.readlines(File.new(ARGV[0]), chomp: true).map(&:to_i)
  sonar_report = SonarReport.new(depth_measurements)

  puts "Part 1: #{sonar_report.increases}" # Expected: 1521
  puts "Part 2: #{sonar_report.window_increases(3)}" # Expected: 1543
end
