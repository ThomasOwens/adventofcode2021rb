# frozen_string_literal: true

# https://adventofcode.com/2021/day/9

class Heightmap
  def initialize(heightmap)
    @heightmap = heightmap
    @rows = heightmap.length
    @columns = heightmap.first.length # Assuming all rows are equal length
  end

  def low_points
    points = {}

    (0..@rows - 1).each do |row|
      (0..@columns - 1).each do |column|
        points[[row, column]] = risk_level(row, column) if low_point?(row, column)
      end
    end

    points
  end

  def basins
    return @basins if @basins

    @basins = {}

    low_points.each_key { |point| @basins[point] = find_basin(point[0], point[1]) }

    @basins
  end

  def basin_sizes
    basins.transform_values(&:length)
  end

  def total_risk_level
    low_points.values.sum
  end

  private

    def low_point?(row, column)
      @heightmap[row][column] < up(row, column) &&
        @heightmap[row][column] < right(row, column) &&
        @heightmap[row][column] < down(row, column) &&
        @heightmap[row][column] < left(row, column)
    end

    def find_basin(row, column)
      basin_points = []

      return basin_points if row > @rows - 1 || row.negative?
      return basin_points if column > @columns - 1 || column.negative?
      return basin_points if @heightmap[row][column] >= 9

      basin_points.append([row, column])
      basin_points.append(*find_basin(row - 1, column)) if @heightmap[row][column] < up(row, column)
      basin_points.append(*find_basin(row, column + 1)) if @heightmap[row][column] < right(row, column)
      basin_points.append(*find_basin(row + 1, column)) if @heightmap[row][column] < down(row, column)
      basin_points.append(*find_basin(row, column - 1)) if @heightmap[row][column] < left(row, column)

      basin_points.compact.uniq
    end

    def risk_level(row, column)
      @heightmap[row][column] + 1
    end

    def up(row, column)
      return 10 if (row - 1).negative?

      @heightmap[row - 1][column]
    end

    def right(row, column)
      return 10 if column + 1 > @columns - 1

      @heightmap[row][column + 1]
    end

    def down(row, column)
      return 10 if row + 1 > @rows - 1

      @heightmap[row + 1][column]
    end

    def left(row, column)
      return 10 if (column - 1).negative?

      @heightmap[row][column - 1]
    end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])
  lines = input_file.readlines
  heightmap = Heightmap.new(lines.map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) })

  pp "Sum of risk levels of all low points: #{heightmap.total_risk_level}" # 631
  pp "Product of three largest basins: #{heightmap.basin_sizes.values.sort.reverse.take(3).inject(:*)}" # 821560
end
