# frozen_string_literal: true

# https://adventofcode.com/2021/day/3

class DiagnosticReport
  def initialize
    @entries = []
  end

  def parse_entry(entry)
    @entries.push(entry)
  end

  def gamma_rate
    most_common_bits = Array.new(bit_analysis(@entries).keys.length)

    bit_analysis(@entries).keys.each_with_index do |_, index|
      most_common_bits[index] = most_common_bit(@entries, index)
    end

    most_common_bits.join.to_i(2)
  end

  def epsilon_rate
    least_common_bits = Array.new(bit_analysis(@entries).keys.length)

    bit_analysis(@entries).keys.each_with_index do |_, index|
      least_common_bits[index] = least_common_bit(@entries, index)
    end

    least_common_bits.join.to_i(2)
  end

  def power_consumption
    gamma_rate * epsilon_rate
  end

  def oxygen_generator_rating
    entries = @entries.clone
    
    current_index = 0

    while entries.length != 1
      keep_bit = if most_common_bit?(entries, current_index)
                   most_common_bit(entries, current_index).to_s
                 else
                   '1'
                 end

      entries.delete_if { |element| element[current_index] != keep_bit }

      current_index += 1
    end

    entries[0].to_i(2)
  end

  def co2_scrubber_rating
    entries = @entries.clone
    
    current_index = 0

    while entries.length != 1
      keep_bit = if most_common_bit?(entries, current_index)
                   least_common_bit(entries, current_index).to_s
                 else
                   '0'
                 end

      entries.delete_if { |element| element[current_index] != keep_bit }

      current_index += 1
    end

    entries[0].to_i(2)
  end

  private

    def bit_analysis(entries)
      bit_analysis = {}

      entries.each do |entry| 
        entry.chars.each_with_index do |value, index|
          if bit_analysis.key?(index)
            if bit_analysis[index].key?(value.to_i)
              bit_analysis[index][value.to_i] += 1
            else
              bit_analysis[index][value.to_i] = 1
            end
          else
            bit_analysis[index] = {}
            bit_analysis[index][value.to_i] = 1
          end
        end
      end

      bit_analysis
    end

    def most_common_bit(entries, index)
      bit_analysis(entries)[index].key(bit_analysis(entries)[index].values.max)
    end

    def least_common_bit(entries, index)
      bit_analysis(entries)[index].key(bit_analysis(entries)[index].values.min)
    end

    def most_common_bit?(entries, index)
      most_common_bit(entries, index) != least_common_bit(entries, index)
    end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  diagnostic_report = DiagnosticReport.new
  File.foreach(File.new(ARGV[0])) { |line| diagnostic_report.parse_entry(line.chomp) }
  
  puts "Part 1: Power Consumption = #{diagnostic_report.power_consumption}" # Expected: 3847100
  puts 'Part 2: Oxygen Generator Rating * CO2 Scrubber Rating = '\
       "#{diagnostic_report.oxygen_generator_rating * diagnostic_report.co2_scrubber_rating}" # Expected: 4105235
end
