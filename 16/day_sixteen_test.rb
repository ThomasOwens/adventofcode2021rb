# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_sixteen'

class PacketTest < MiniTest::Test
  def test_parse_literal_packet
    packet = Packet.new(Packet.hex_string_to_binary_string('D2FE28'))

    assert_equal(6, packet.version)
    assert_equal(4, packet.type_id)
    assert_equal(2021, packet.value)
  end

  def test_parse_operator_packet_length_id_zero
    packet = Packet.new(Packet.hex_string_to_binary_string('38006F45291200'))

    assert_equal(1, packet.version)
    assert_equal(6, packet.type_id)
    assert_equal('0', packet.length_type_id)
    assert_equal(2, packet.number_of_subpackets)
    assert_equal(10, packet.subpackets[0].value)
    assert_equal(20, packet.subpackets[1].value)
  end

  def test_parse_operator_packet_length_id_one
    packet = Packet.new(Packet.hex_string_to_binary_string('EE00D40C823060'))

    assert_equal(7, packet.version)
    assert_equal(3, packet.type_id)
    assert_equal('1', packet.length_type_id)
    assert_equal(3, packet.number_of_subpackets)
    assert_equal(1, packet.subpackets[0].value)
    assert_equal(2, packet.subpackets[1].value)
    assert_equal(3, packet.subpackets[2].value)
  end

  def test_additional_part_one_examples
    packet = Packet.new(Packet.hex_string_to_binary_string('8A004A801A8002F478'))
    assert_equal(4, packet.version)
    assert_equal(1, packet.subpackets[0].version)
    assert_equal(5, packet.subpackets[0].subpackets[0].version)
    assert_equal(6, packet.subpackets[0].subpackets[0].subpackets[0].version)
    assert_equal(16, packet.version_sum)

    packet = Packet.new(Packet.hex_string_to_binary_string('620080001611562C8802118E34'))
    assert_equal(12, packet.version_sum)

    packet = Packet.new(Packet.hex_string_to_binary_string('C0015000016115A2E0802F182340'))
    assert_equal(23, packet.version_sum)

    packet = Packet.new(Packet.hex_string_to_binary_string('A0016C880162017C3686B18A3D4780'))
    assert_equal(31, packet.version_sum)
  end

  def test_additional_part_two_examples
    assert_equal(3, Packet.new(Packet.hex_string_to_binary_string('C200B40A82')).value)

    assert_equal(54, Packet.new(Packet.hex_string_to_binary_string('04005AC33890')).value)

    assert_equal(7, Packet.new(Packet.hex_string_to_binary_string('880086C3E88112')).value)

    assert_equal(9, Packet.new(Packet.hex_string_to_binary_string('CE00C43D881120')).value)

    assert_equal(1, Packet.new(Packet.hex_string_to_binary_string('D8005AC2A8F0')).value)

    assert_equal(0, Packet.new(Packet.hex_string_to_binary_string('F600BC2D8F')).value)

    assert_equal(0, Packet.new(Packet.hex_string_to_binary_string('9C005AC2F8F0')).value)

    assert_equal(1, Packet.new(Packet.hex_string_to_binary_string('9C0141080250320F1802104A08')).value)
  end
end
