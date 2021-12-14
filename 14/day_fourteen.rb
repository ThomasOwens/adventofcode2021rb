# frozen_string_literal: true

# https://adventofcode.com/2021/day/14

class Polymerization
  def initialize(polymer_template, pair_insertion_rules)
    @polymer_template = polymer_template
    @pair_insertion_rules = pair_insertion_rules
    @polymer_pairs = polymer_to_polymer_pairs(@polymer_template)
  end

  def pair_insertion_process
    before_insertion = @polymer_pairs.dup

    before_insertion.each_pair do |pair, count|
      @polymer_pairs[pair] -= count

      element_to_insert = @pair_insertion_rules[pair]
      @polymer_pairs[pair[0] + element_to_insert] += count
      @polymer_pairs[element_to_insert + pair[1]] += count
    end
  end

  def element_counts
    counts = {}

    counts[@polymer_template[-1]] = 1

    @polymer_pairs.each_pair do |pair, count|
      if counts.key?(pair[0])
        counts[pair[0]] += count
      else
        counts[pair[0]] = count
      end
    end

    counts
  end

  private

    def polymer_to_polymer_pairs(polymer_string)
      polymer_pairs = @pair_insertion_rules.transform_values { |_insertion| 0 }

      polymer_string.chars.each_cons(2) do |polymer_pair|
        polymer_pairs[polymer_pair.join] += 1
      end

      polymer_pairs
    end
end

if $PROGRAM_NAME == __FILE__
  input_file = File.new(ARGV[0])
  lines = input_file.readlines

  polymer_template = ''
  pair_insertion_rules = {}

  lines.each do |line|
    line = line.chomp

    next if line.empty?

    if line.include?('->') # Pair insertion rule
      rule = line.split('->')
      pair_insertion_rules[rule[0].strip] = rule[1].strip
    else
      polymer_template = line.strip
    end
  end

  polymerization = Polymerization.new(polymer_template, pair_insertion_rules)

  10.times { polymerization.pair_insertion_process }

  minmax = polymerization.element_counts.values.minmax
  pp "Quantity of least common element subtracted from quantity of the most common element: #{minmax[1] - minmax[0]}"

  30.times { polymerization.pair_insertion_process }

  minmax = polymerization.element_counts.values.minmax
  pp "Quantity of least common element subtracted from quantity of the most common element: #{minmax[1] - minmax[0]}"
end
