# frozen_string_literal: true

# https://adventofcode.com/2021/day/7

class CrabmarineFleet
  def initialize(submarine_locations)
    @submarine_start_locations = submarine_locations.clone
  end

  def fuel_to_move_to(location)
    @submarine_start_locations.sum { |submarine_location| ((submarine_location - location).abs * ((submarine_location - location).abs + 1))/2 }
  end

  def fuel_to_align(start_loc, end_loc)
    raise InvalidArgumentException, 'start must be smaller than end' unless start_loc < end_loc

    fuel_needed = Hash.new(0)

    (start_loc..end_loc).each { |tgt_location| fuel_needed[tgt_location] = fuel_to_move_to(tgt_location) }
    
    fuel_needed.sort_by { |_key, value| value }.to_h
  end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])
  crabmarine_locations = input_file.readline.split(',').map(&:to_i)

  crabmarine_fleet = CrabmarineFleet.new(crabmarine_locations)
  fuel_to_align = crabmarine_fleet.fuel_to_align(crabmarine_locations.min, crabmarine_locations.max)

  pp "The crabmarine fleet will use #{fuel_to_align.values.first} fuel"
  # Part One Expected: 329389
  # Part Two Expected: 86397080
end
