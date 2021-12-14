# frozen_string_literal: true

# https://adventofcode.com/2021/day/14

class Polymerization
  def initialize(polymer_template, pair_insertion_rules)
    @polymer_template = polymer_template
    @current_polymer = polymer_template.dup
    @pair_insertion_rules = pair_insertion_rules
  end

  def pair_insertion_process
    elements_to_insert = []

    @current_polymer.chars.each_cons(2) do |pair|
      elements_to_insert.append(@pair_insertion_rules[pair.join])
    end

    @current_polymer = @current_polymer.chars.flat_map { |element| [element, elements_to_insert.shift] }.join
  end

  def element_counts
    elements = @current_polymer.chars.uniq.sort

    element_counts = {}

    elements.each { |element| element_counts[element] = @current_polymer.count(element) }

    element_counts
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

  pp "Quantity of least common element subtracted from quantity of the most common element: #{polymerization.element_counts.values.max - polymerization.element_counts.values.min}"

  30.times { polymerization.pair_insertion_process }

  pp "Quantity of least common element subtracted from quantity of the most common element: #{polymerization.element_counts.values.max - polymerization.element_counts.values.min}"
end
