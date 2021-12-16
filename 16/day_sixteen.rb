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

  def self.parse_packet(binary_string)
    parsed_packet = {}

    parsed_packet[:version] = binary_string.slice!(0..2).to_i(2)
    parsed_packet[:type_id] = binary_string.slice!(0..2).to_i(2)

    if parsed_packet[:type_id] == 4 # literal value that encodes a single binary number
      parsed_packet[:group_a] = binary_string.slice!(0..4).slice(1..4)
      parsed_packet[:group_b] = binary_string.slice!(0..4).slice(1..4)
      parsed_packet[:group_c] = binary_string.slice!(0..4).slice(1..4)
      parsed_packet[:literal_value_bin] = parsed_packet[:group_a] + parsed_packet[:group_b] + parsed_packet[:group_c]
      parsed_packet[:literal_value_dec] = parsed_packet[:literal_value_bin].to_i(2)
    else # packet is an operator
      parsed_packet[:length_type_id] = binary_string.slice!(0)
      parsed_packet[:subpackets] = []

      if parsed_packet[:length_type_id] == '0'
        length_of_subpackets = binary_string.slice!(0..14)

        while binary_string.size > 0 do
          # TODO This is failing to fully parse the packets and causing exceptions.
          parsed_packet[:subpackets].push(parse_packet(binary_string))
        end
      else # parsed_packet['length_type_id'] == '1'
        parsed_packet[:number_of_subpackets] = binary_string.slice!(0..10).to_i(2)

        while parsed_packet[:subpackets].length > parsed_packet[:number_of_subpackets] do
          # TODO This isn't appending to the subpackets array.
          parsed_packet[:subpackets].push(parse_packet(binary_string))
        end
      end
    end

    parsed_packet
  end

  def self.parse_hex_string(hex_string)
    hex_string.chars.map { |hex_char| HEX_TO_BINARY[hex_char] }.join
  end
end
