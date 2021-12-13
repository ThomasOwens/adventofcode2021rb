# frozen_string_literal: true

# https://adventofcode.com/2021/day/12

class CaveSystem
  def initialize
    @cave_system = {}
  end

  def add_cave(cave)
    @cave_system[cave] = [] unless @cave_system.key?(cave)
  end

  def add_tunnel(from_cave, to_cave)
    @cave_system[from_cave] = [] unless @cave_system.key?(from_cave)
    @cave_system[to_cave] = [] unless @cave_system.key?(to_cave)

    @cave_system[from_cave].append(to_cave)
    @cave_system[to_cave].append(from_cave)
  end

  def connected?(from_cave, to_cave)
    @cave_system[from_cave].include?(to_cave)
  end

  def size
    @cave_system.size
  end

  def paths(from_cave, to_cave, can_revisit_small_caves = false)
    paths = []
    path_search(from_cave, to_cave, paths, can_revisit_small_caves)
    paths
  end

  def self.big_cave?(cave)
    cave == cave.upcase
  end

  def self.small_cave?(cave)
    cave == cave.downcase
  end

  private

    def path_search(current_cave, end_cave, paths, can_revisit_small_caves, path = [])
      path.append(current_cave)

      if current_cave == end_cave
        paths.append(path)
        return
      end

      @cave_system[current_cave].each do |connected_cave|
        unless fully_visited?(connected_cave, path, can_revisit_small_caves)
          path_search(connected_cave, end_cave, paths, can_revisit_small_caves, path.dup)
        end
      end
    end

    def fully_visited?(cave, path, can_revisit_small_caves)
      return true if cave == 'start' && path.include?(cave)
      return true if cave == 'end' && path.include?(cave)
      return false if CaveSystem.big_cave?(cave)

      if can_revisit_small_caves
        return true if path.include?(cave) && path.count(cave) >= 2
        return true if path.include?(cave) && path.any? { |past_cave| CaveSystem.small_cave?(past_cave) && path.count(past_cave) >= 2 }
        return false
      else # can't revisit small caves
        return path.include?(cave)
      end
    end
end

if $PROGRAM_NAME == __FILE__
  input_file = File.new(ARGV[0])
  lines = input_file.readlines

  cave_system = CaveSystem.new

  lines.each do |line|
    caves = line.split('-').map(&:chomp)
    cave_system.add_tunnel(caves[0], caves[1])
  end

  pp "Paths: #{cave_system.paths('start', 'end', false).length}" # Part 1: 4707
  pp "Paths: #{cave_system.paths('start', 'end', true).length}" # Part 2: 130493
end
