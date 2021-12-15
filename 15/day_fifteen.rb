# frozen_string_literal: true

# https://adventofcode.com/2021/day/15

class RiskMap
  def initialize(risk_map)
    @risk_map = risk_map
    @height = risk_map.length
    @width = risk_map.first.length # Assuming all are equal
  end

  def navigate
    best_paths = {}
    paths([0, 0], [@height - 1, @width - 1], best_paths)
    best_paths
  end

  private

    def paths(current_location, target_location, best_paths, path = [[], []])
      path[0].append(current_location)
      path[1].append(@risk_map[current_location[0]][current_location[1]])
      current_risk = path[1][1..].sum

      return if best_paths.any? && (current_risk > best_paths.values.first)

      if current_location == target_location
        best_paths.delete_if { |_existing_path, existing_path_risk| existing_path_risk > current_risk }
        best_paths[path] = current_risk
        return
      end

      neighbors(current_location).each do |neighbor|
        paths(neighbor, target_location, best_paths, [path[0].dup, path[1].dup]) unless path[0].include?(neighbor)
      end
    end

    def neighbors(source)
      neighbors = []

      neighbors.push([source[0] - 1, source[1]]) if source[0] - 1 >= 0 # Up
      neighbors.push([source[0], source[1] + 1]) if source[1] + 1 < @width # Right
      neighbors.push([source[0] + 1, source[1]]) if source[0] + 1 < @height # Down
      neighbors.push([source[0], source[1] - 1]) if source[1] - 1 >= 0 # Left

      neighbors
    end
end

if $PROGRAM_NAME == __FILE__
  input_file = File.new(ARGV[0])
  lines = input_file.readlines

  risk_map = RiskMap.new(lines.map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) })
  best_paths = risk_map.navigate

  pp "Total Paths: #{best_paths.size} "
  pp "Lowest Total Risk: #{best_paths.first[1]}"
end
