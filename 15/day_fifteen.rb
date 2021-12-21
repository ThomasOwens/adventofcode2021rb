# frozen_string_literal: true

# https://adventofcode.com/2021/day/15

require 'benchmark'

class RiskMap
  def initialize(risk_map, repeating = 1)
    @risk_map = risk_map
    @reading_height = risk_map.length
    @reading_width = risk_map.first.length
    @height = risk_map.length * repeating
    @width = risk_map.first.length * repeating
  end

  def navigate
    start_location = [0, 0]
    target_location = [@height - 1, @width - 1]

    _, previous = pathfinding(start_location, target_location)

    path = []
    path.push(target_location)

    path.push(previous[path.last]) until path.last == [0, 0]

    path.reverse!

    [path, path_risk_level(path)]
  end

  private

    def risk(row_num, column_num)
      row_factor, reading_row = row_num.divmod(@reading_height)
      col_factor, reading_column = column_num.divmod(@reading_width)

      risk = @risk_map[reading_row][reading_column] + row_factor + col_factor
      risk = ((risk % 9) + 1) if risk > 9

      risk
    end

    def pathfinding(start_location, target_location)
      locations_to_visit = []
      distances = {}
      previous = {}

      (0..(@height - 1)).each do |row_num|
        (0..(@width - 1)).each do |column_num|
          distances[[row_num, column_num]] = Float::INFINITY
          previous[[row_num, column_num]] = nil
          locations_to_visit.push([row_num, column_num])
        end
      end

      distances[start_location] = 0

      until locations_to_visit.empty?
        locations_to_visit.sort_by! { |location| distances[location] }
        current_location = locations_to_visit.first
        locations_to_visit.delete(current_location)

        return distances, previous if current_location == target_location

        neighbors(current_location).each do |neighbor|
          next unless locations_to_visit.include?(neighbor)

          distance = distances[current_location] + risk(neighbor[0], neighbor[1])

          if distance < distances[neighbor]
            distances[neighbor] = distance
            previous[neighbor] = current_location
          end
        end
      end

      [distances, previous]
    end

    def neighbors(location)
      neighbors = []

      neighbors.push([location[0] - 1, location[1]]) if location[0] - 1 >= 0 # Up
      neighbors.push([location[0], location[1] + 1]) if location[1] + 1 < @width # Right
      neighbors.push([location[0] + 1, location[1]]) if location[0] + 1 < @height # Down
      neighbors.push([location[0], location[1] - 1]) if location[1] - 1 >= 0 # Left

      neighbors
    end

    def path_risk_level(path)
      cumulative_risk = 0

      path.each_with_index do |location, index|
        next if index.zero?

        cumulative_risk += risk(location[0], location[1])
      end

      cumulative_risk
    end
end

if $PROGRAM_NAME == __FILE__
  input_file = File.new(ARGV[0])
  lines = input_file.readlines
  risk_map_grid = lines.map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) }

  # The input is the whole map for part 1
  risk_map = RiskMap.new(risk_map_grid)
  _, risk = risk_map.navigate
  pp "Lowest Risk: #{risk}" # Expected: 540

  # Expand the map for part 2
end
