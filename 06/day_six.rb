# frozen_string_literal: true

# https://adventofcode.com/2021/day/6

class LanternfishSchool
  def initialize
    @school = Array.new(9, 0)
  end

  def add_fish(age)
    @school[age] += 1
  end

  def age
    making_new_fish = @school.shift
    @school[8] = making_new_fish
    @school[6] += making_new_fish
  end

  def school_size
    @school.sum
  end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])
  input_line = input_file.readline.split(',')

  school = LanternfishSchool.new
  input_line.each { |fish| school.add_fish(fish.to_i) }
  Array.new(80).collect { school.age }
  pp "Part 1: After 80 days, there are #{school.school_size} lanternfish in the school" # Expected: 374927

  school = LanternfishSchool.new
  input_line.each { |fish| school.add_fish(fish.to_i) }
  Array.new(256).collect { school.age }
  pp "Part 1: After 256 days, there are #{school.school_size} lanternfish in the school" # Expected: 1687617803407
end
