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

  def paths(from_cave, to_cave)
    paths = []
    path_search(from_cave, to_cave, paths)
    paths
  end

  def self.big_cave?(cave)
    cave == cave.upcase
  end

  private

    def path_search(current_cave, end_cave, paths = [], path = [], visited = [])
      visited.append(current_cave) unless CaveSystem.big_cave?(current_cave)

      path.append(current_cave)

      if current_cave == end_cave
        paths.append(path)
        return path
      end

      @cave_system[current_cave].each do |connected_cave|
        path_search(connected_cave, end_cave, paths, path, visited) unless visited.include?(connected_cave)
      end
    end
end
