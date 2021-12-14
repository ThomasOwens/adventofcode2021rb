# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'day_fourteen'

class PolymerizationTest < MiniTest::Test
  def test_part_one_example
    polymer_template = 'NNCB'

    pair_insertion_rules = {
      'CH' => 'B',
      'HH' => 'N',
      'CB' => 'H',
      'NH' => 'C',
      'HB' => 'C',
      'HC' => 'B',
      'HN' => 'C',
      'NN' => 'C',
      'BH' => 'H',
      'NC' => 'B',
      'NB' => 'B',
      'BN' => 'B',
      'BB' => 'N',
      'BC' => 'B',
      'CC' => 'N',
      'CN' => 'C'
    }

    polymerization = Polymerization.new(polymer_template, pair_insertion_rules)

    # Step 1
    assert_equal('NCNBCHB', polymerization.pair_insertion_process)
    assert_equal(7, polymerization.element_counts.values.sum)

    # Step 2
    assert_equal('NBCCNBBBCBHCB', polymerization.pair_insertion_process)
    assert_equal(13, polymerization.element_counts.values.sum)

    # Step 3
    assert_equal('NBBBCNCCNBBNBNBBCHBHHBCHB', polymerization.pair_insertion_process)
    assert_equal(25, polymerization.element_counts.values.sum)

    # Step 4
    assert_equal('NBBNBNBBCCNBCNCCNBBNBBNBBBNBBNBBCBHCBHHNHCBBCBHCB', polymerization.pair_insertion_process)
    assert_equal(49, polymerization.element_counts.values.sum)

    # Step 5
    polymerization.pair_insertion_process

    # Step 6
    polymerization.pair_insertion_process

    # Step 7
    polymerization.pair_insertion_process

    # Step 8
    polymerization.pair_insertion_process

    # Step 9
    polymerization.pair_insertion_process
    
    # Step 10
    polymerization.pair_insertion_process
    assert_equal(3073, polymerization.element_counts.values.sum)
    assert_equal(1749, polymerization.element_counts['B'])
    assert_equal(865, polymerization.element_counts['N'])
    assert_equal(298, polymerization.element_counts['C'])
    assert_equal(161, polymerization.element_counts['H'])
  end
end
