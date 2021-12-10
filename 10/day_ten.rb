# frozen_string_literal: true

# https://adventofcode.com/2021/day/10

class NavigationSubsystem
  OPENING_CHARS = ['(', '[', '{', '<'].freeze
  CLOSING_CHARS = [')', ']', '}', '>'].freeze

  def initialize(lines)
    @lines = lines
  end

  def corrupted_lines
    corrupted_lines = {}

    @lines.each do |line|
      line_corruption = corruption(line)
      corrupted_lines[line] = line_corruption if corruption(line).any?
    end

    corrupted_lines
  end

  def score_corruption
    score = 0

    corrupted_lines.each_value do |corruption|
      case corruption.first[:invalid_char]
      when ')'
        score += 3
      when ']'
        score += 57
      when '}'
        score += 1197
      when '>'
        score += 25137
      end
    end

    score
  end

  private

    def corruption(line)
      opening = []
      corruption = []

      line.chars.each_with_index do |character, index|
        opening.push(character) if OPENING_CHARS.include?(character)

        next unless CLOSING_CHARS.include?(character)

        expected_opening = opening.pop

        if OPENING_CHARS.index(expected_opening) != CLOSING_CHARS.index(character)
          corruption.push({ invalid_char: character, 
                            index: index })
        end
      end

      corruption
    end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])
  lines = input_file.readlines.map(&:chomp)

  nav_subsystem = NavigationSubsystem.new(lines)

  pp "Total Syntax Error Score for Corrupted Lines: #{nav_subsystem.score_corruption}" # 288291
end
