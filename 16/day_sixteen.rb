# frozen_string_literal: true

# https://adventofcode.com/2021/day/16

class Packet
  HEX_TO_BINARY = {
    '0' => '0000',
    '1' => '0001',
    '2' => '0010',
    '3' => '0011',
    '4' => '0100',
    '5' => '0101',
    '6' => '0110',
    '7' => '0111',
    '8' => '1000',
    '9' => '1001',
    'A' => '1010',
    'B' => '1011',
    'C' => '1100',
    'D' => '1101',
    'E' => '1110',
    'F' => '1111'
  }.freeze

  attr_reader :version, :type_id, :length_type_id, :subpackets

  def initialize(packet_binary_string)
    parse_binary_string(packet_binary_string)
  end

  def number_of_subpackets
    @subpackets.length
  end

  def value
    # This returns an incorrect value for Part 2, but none of the existing tests expose the issue.

    case @type_id
    when 0
      @subpackets.sum(&:value)
    when 1
      @subpackets.map(&:value).reduce(:*)
    when 2
      @subpackets.map(&:value).min
    when 3
      @subpackets.map(&:value).max
    when 4
      @groups.join.to_i(2)
    when 5
      @subpackets[0].value > @subpackets[1].value ? 1 : 0
    when 6
      @subpackets[0].value < @subpackets[1].value ? 1 : 0
    when 7
      @subpackets[0].value == @subpackets[1].value ? 1 : 0
    end
  end

  def version_sum
    version_sum = version

    version_sum += subpackets.sum(&:version_sum) unless subpackets.nil?

    version_sum
  end

  def self.hex_string_to_binary_string(hex_string)
    hex_string.chars.map { |hex_char| HEX_TO_BINARY[hex_char] }.join
  end

  private

    def parse_binary_string(binary_string)
      @version = binary_string.slice!(0..2).to_i(2)
      @type_id = binary_string.slice!(0..2).to_i(2)

      if @type_id == 4
        @groups = []

        loop do
          break_char = binary_string.slice!(0)
          @groups.push(binary_string.slice!(0..3))

          break if break_char == '0'
        end
      else
        @length_type_id = binary_string.slice!(0)
        @subpackets = []

        if @length_type_id == '0'
          subpackets_length = binary_string.slice!(0..14).to_i(2)
          packet_data = binary_string.slice!(0..(subpackets_length-1))

          while !packet_data.empty?
            @subpackets.push(Packet.new(packet_data))
          end
        else
          number_of_subpackets = binary_string.slice!(0..10).to_i(2)

          @subpackets.push(Packet.new(binary_string)) while @subpackets.length < number_of_subpackets
        end
      end
    end
end

if $PROGRAM_NAME == __FILE__
  input_file = File.new(ARGV[0])
  line = input_file.readline

  packet = Packet.new(Packet.hex_string_to_binary_string(line))

  pp "Version Sum: #{packet.version_sum}" # Expected: 984
  pp "Value: #{packet.value}"
end
