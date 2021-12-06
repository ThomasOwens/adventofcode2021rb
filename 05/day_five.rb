# frozen_string_literal: true

# https://adventofcode.com/2021/day/5

class HydrothermalVent
  @start = {}
  @end = {}

  def initialize(start_x, start_y, end_x, end_y)
    @start = { x: start_x, y: start_y }
    @end = { x: end_x, y: end_y }
  end

  def horizontal?
    @start[:y] == @end[:y]
  end

  def vertical?
    @start[:x] == @end[:x]
  end

  def diagonal?
    !horizontal? && !vertical?
  end

  def points
    if horizontal?
      plot_horizontal_points
    elsif vertical?
      plot_vertical_points
    else
      plot_diagonal_points
    end
  end

  private

    def plot_horizontal_points
      points = []
      beginning = @start[:x] > @end[:x] ? @end[:x] : @start[:x]
      ending = @start[:x] > @end[:x] ? @start[:x] : @end[:x]

      (beginning..ending).each { |x_val| points.push([x_val, @start[:y]]) }

      points
    end

    def plot_vertical_points
      points = []
      beginning = @start[:y] > @end[:y] ? @end[:y] : @start[:y]
      ending = @start[:y] > @end[:y] ? @start[:y] : @end[:y]

      (beginning..ending).each { |y_val| points.push([@start[:x], y_val]) }

      points
    end

    # Diagonal lines will always be 45 degrees.
    def plot_diagonal_points
      beginning_x = @start[:x] > @end[:x] ? @end[:x] : @start[:x]
      ending_x = @start[:x] > @end[:x] ? @start[:x] : @end[:x]
      xs = (beginning_x..ending_x).to_a
      xs.reverse! if @end[:x] > @start[:x]

      beginning_y = @start[:y] > @end[:y] ? @end[:y] : @start[:y]
      ending_y = @start[:y] > @end[:y] ? @start[:y] : @end[:y]
      ys = (beginning_y..ending_y).to_a
      ys.reverse! if @end[:y] > @start[:y]

      xs.zip(ys)
    end
end

class OceanFloor
  def initialize(danger_threshold = 2)
    @vents = {}
    @danger_threshold = danger_threshold
  end

  def add_vent(vent)
    vent.points.each do |vent_point|
      @vents[vent_point] = if @vents.key?(vent_point)
                             @vents[vent_point] + 1
                           else
                             1
                           end
    end
  end

  def vent_points
    @vents.sort_by { |_key, value| -value }.to_h
  end

  def dangerous_vent_points
    vent_points.reject { |_key, value| value < @danger_threshold }
  end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  input_file = File.new(ARGV[0])

  coordinate_lines = input_file.readlines.map(&:strip).map { |coord_pair| coord_pair.split(' -> ') }
  coordinate_pairs = coordinate_lines.map { |coord_pair| coord_pair.map { |coord| coord.split(',').map(&:to_i) } }

  hydrothermal_vents = []
  coordinate_pairs.each do |coordinate_pair|
    hydrothermal_vents.push(HydrothermalVent.new(coordinate_pair[0][0], coordinate_pair[0][1], coordinate_pair[1][0], 
                                                 coordinate_pair[1][1]))
  end

  ocean_floor = OceanFloor.new
  hydrothermal_vents.reject(&:diagonal?).each { |vent| ocean_floor.add_vent(vent) }
  pp "Part 1: #{ocean_floor.dangerous_vent_points.size} dangerous points" # Expected: 5576

  ocean_floor = OceanFloor.new
  hydrothermal_vents.each { |vent| ocean_floor.add_vent(vent) }
  pp "Part 2: #{ocean_floor.dangerous_vent_points.size} dangerous points" # Expected: 18144
end
