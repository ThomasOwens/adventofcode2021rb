# frozen_string_literal: true

# https://adventofcode.com/2021/day/8

class SevenSegmentDisplay
  def initialize(signal_patterns, output_value)
    @input = signal_patterns
    @output = output_value.map { |element| element.chars.sort }
  end

  def mapping
    return @mapping if @mapping

    @mapping = Array.new(10, 0)
    @mapping[1] = @input.find { |pattern| pattern.length == 2 }.chars.sort
    @mapping[4] = @input.find { |pattern| pattern.length == 4 }.chars.sort
    @mapping[7] = @input.find { |pattern| pattern.length == 3 }.chars.sort
    @mapping[8] = @input.find { |pattern| pattern.length == 7 }.chars.sort
    @mapping[3] = @input.find do |pattern|
      pattern.length == 5 && (pattern.chars.sort - mapping[1]).length == 3
    end.chars.sort
    @mapping[5] = @input.find do |pattern|
      pattern.length == 5 && (pattern.chars.sort - mapping[1]).length == 4 &&
        (pattern.chars.sort - mapping[4]).length == 2
    end.chars.sort
    @mapping[2] = @input.find do |pattern|
      pattern.length == 5 && (pattern.chars.sort - mapping[4]).length == 3
    end.chars.sort
    @mapping[6] = @input.find do |pattern|
      pattern.length == 6 && (pattern.chars.sort - mapping[1]).length == 5
    end.chars.sort
    @mapping[9] = @input.find do |pattern|
      pattern.length == 6 && (pattern.chars.sort - mapping[3]).length == 1
    end.chars.sort
    @mapping[0] = @input.find do |pattern|
      pattern.length == 6 && (pattern.chars.sort - mapping[6]).length == 1 &&
        (pattern.chars.sort - mapping[9]).length == 1
    end.chars.sort
    @mapping
  end

  def output_value
    [mapping.index(@output[0]), mapping.index(@output[1]), mapping.index(@output[2]), 
     mapping.index(@output[3])].join.to_i
  end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  sum_of_output_values = 0

  input_file = File.new(ARGV[0])
  entries = input_file.readlines
  entries.each do |entry|
    split_entries = entry.split('|')
    display = SevenSegmentDisplay.new(split_entries[0].strip.split, split_entries[1].strip.split)
    sum_of_output_values += display.output_value
  end

  pp "Sum of Output Values: #{sum_of_output_values}"
end
