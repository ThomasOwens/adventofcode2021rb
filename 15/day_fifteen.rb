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

    def paths(current_location, target_location, best_paths, path = [])
      path.append(current_location)
      current_path_risk = path_risk(path)

      return if best_paths.any? && (current_path_risk > best_paths.values.first)

      if current_location == target_location
        best_paths.delete_if { |_existing_path, existing_path_risk| existing_path_risk > current_path_risk }
        best_paths[path] = current_path_risk
        return
      end

      neighbors(current_location).each do |neighbor|
        paths(neighbor, target_location, best_paths, path.dup) unless path.include?(neighbor)
      end
    end

    def path_risk(path)
      cumulative_risk = 0

      path.slice(1..-1).each do |location|
        cumulative_risk += @risk_map[location[0]][location[1]]
      end

      cumulative_risk
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
  pp "Lowest Total Risk: #{best_paths.values.first}"
end