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

  def incomplete_lines
    unfinished_lines = {}

    (@lines - corrupted_lines.keys).each do |line|
      unfinished_lines[line] = complete(line)
    end

    unfinished_lines
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

  def score_completions
    scores = {}

    incomplete_lines.each_value do |completion|
      score = 0
      
      completion.chars.each do |completion_char|
        score *= 5

        case completion_char
        when ')'
          score += 1
        when ']'
          score += 2
        when '}'
          score += 3
        when '>'
          score += 4
        end
      end

      scores[completion] = score
    end

    scores
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

    def complete(line)
      left_open = []
      ending = []

      line.chars.each do |character|
        left_open.push(character) if OPENING_CHARS.include?(character)
        left_open.pop if CLOSING_CHARS.include?(character)
      end

      while left_open.any?
        next_char = left_open.pop

        case next_char
        when '('
          ending.push(')')
        when '['
          ending.push(']')
        when '{'
          ending.push('}')
        when '<'
          ending.push('>')
        end
      end

      ending.join
    end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])
  lines = input_file.readlines.map(&:chomp)

  nav_subsystem = NavigationSubsystem.new(lines)

  pp "Syntax Error Score: #{nav_subsystem.score_corruption}"
  # 288291

  autocomplete_scores = nav_subsystem.score_completions
  pp "Winning Auto-Complete Score: #{autocomplete_scores.values.sort[autocomplete_scores.length / 2]}"
  # 820045242
end
