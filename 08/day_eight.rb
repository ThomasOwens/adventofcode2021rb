# frozen_string_literal: true

# https://adventofcode.com/2021/day/8

class SevenSegmentDisplay
  def initialize
    @display = {}
    @digits = {}
  end

  def add_entry(signal_patterns, output_value)
    raise IllegalArgumentException, 'incorrect number of signal patterns' unless signal_patterns.length == 10
    raise IllegalArgumentException, 'incorrect output value' unless output_value.length == 4

    @display[signal_patterns] = output_value
  end

  def signal_patterns
    @display.keys
  end

  def output_values
    @display.values
  end

  def output_value_digits
    digits = Array.new(10, 0)

    output_values.each do |output_value| 
      output_value.each do |output_value_digit|
        digits[output_value_to_digit(output_value_digit)] += 1
      end                                        
    end    

    digits
  end

  private

    def output_value_to_digit(output_value)
      return 1 if output_value.length == 2
      return 4 if output_value.length == 4
      return 7 if output_value.length == 3
      return 8 if output_value.length == 7

      0
    end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])

  display = SevenSegmentDisplay.new

  entries = input_file.readlines
  entries.each do |entry|
    split_entries = entry.split('|')
    display.add_entry(split_entries[0].strip.split, split_entries[1].strip.split)
  end

  # Part 1
  num_digits = display.output_value_digits[1] + display.output_value_digits[4] +
               display.output_value_digits[7] + display.output_value_digits[8]
  pp "Digits with unique number of segments: #{num_digits}" # Expected: 344
end
