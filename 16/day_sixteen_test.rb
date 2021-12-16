# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_sixteen'

class PacketTest < MiniTest::Test
  def test_parse_hex_string
    assert_equal('110100101111111000101000', Packet.parse_hex_string('D2FE28'))
    assert_equal('00111000000000000110111101000101001010010001001000000000', Packet.parse_hex_string('38006F45291200'))
    assert_equal('11101110000000001101010000001100100000100011000001100000', Packet.parse_hex_string('EE00D40C823060'))
  end

  def test_parse_literal_packet
    packet = Packet.parse_hex_string('D2FE28')

    parsed_packet = Packet.parse_packet(packet)

    assert_equal(6, parsed_packet[:version])
    assert_equal(4, parsed_packet[:type_id])
    assert_equal("0111", parsed_packet[:group_a])
    assert_equal("1110", parsed_packet[:group_b])
    assert_equal("0101", parsed_packet[:group_c])
    assert_equal(2021, parsed_packet[:literal_value_dec])
  end

  def test_parse_operator_packet_length_id_0
    packet = Packet.parse_hex_string('38006F45291200')
    parsed_packet = Packet.parse_packet(packet)

    assert_equal(1, parsed_packet[:version])
    assert_equal(6, parsed_packet[:type_id])
    assert_equal('0', parsed_packet[:length_type_id])
    assert_equal(2, parsed_packet[:subpackets].length)
  end

  def test_parse_operator_packet_length_id_1
    packet = Packet.parse_hex_string('EE00D40C823060')
    parsed_packet = Packet.parse_packet(packet)

    assert_equal(7, parsed_packet[:version])
    assert_equal(3, parsed_packet[:type_id])
    assert_equal('1', parsed_packet[:length_type_id])
    assert_equal(3, parsed_packet[:length_of_subpackets])
    assert_equal(3, parsed_packet[:subpackets].length)
    assert_equal(1, parsed_packet[:subpackets][0][:literal_value_dec])
    assert_equal(2, parsed_packet[:subpackets][1][:literal_value_dec])
    assert_equal(3, parsed_packet[:subpackets][2][:literal_value_dec])
  end
end

# More Tests to Write:

# 8A004A801A8002F478 represents an operator packet (version 4) which contains an operator packet (version 1) which
# contains an operator packet (version 5) which contains a literal value (version 6); this packet has a version sum of
# 16.

# 620080001611562C8802118E34 represents an operator packet (version 3) which contains two sub-packets; each sub-packet
# is an operator packet that contains two literal values. This packet has a version sum of 12.

# C0015000016115A2E0802F182340 has the same structure as the previous example, but the outermost packet uses a
# different length type ID. This packet has a version sum of 23.

# A0016C880162017C3686B18A3D4780 is an operator packet that contains an operator packet that contains an operator
# packet that contains five literal values; it has a version sum of 31.
