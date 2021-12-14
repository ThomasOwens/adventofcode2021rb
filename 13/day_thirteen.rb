# frozen_string_literal: true

# https://adventofcode.com/2021/day/13

class Grid
  attr_reader :points

  def initialize
    @points = []
  end

  def add_point(x_coord, y_coord)
    @points.push([x_coord, y_coord])
  end

  def fold_x(x_fold_line)
    @points.map! do |point|
      point[0] > x_fold_line ? [(x_fold_line - (point[0] - x_fold_line)), point[1]] : [point[0], point[1]]
    end    
    @points = @points.uniq
  end

  def fold_y(y_fold_line)
    @points.map! do |point|
      point[1] > y_fold_line ? [point[0], (y_fold_line - (point[1] - y_fold_line))] : [point[0], point[1]]
    end    
    @points = @points.uniq
  end

  def grid_array
    max_x, max_y = max_values

    output_grid = Array.new(max_y + 1) { Array.new(max_x + 1) }

    (0..max_y).each do |y_coord|
      (0..max_x).each do |x_coord|
        output_grid[y_coord][x_coord] = @points.include?([x_coord, y_coord]) ? '#' : '.'
      end
    end

    output_grid
  end

  private

    def max_values
      max_x = 0
      max_y = 0

      @points.each do |point|
        max_x = point[0] if point[0] > max_x
        max_y = point[1] if point[1] > max_y
      end

      [max_x, max_y]
    end
end

if $PROGRAM_NAME == __FILE__
  coord_lines = []
  fold_lines = []

  input_file = File.new(ARGV[0])
  input_lines = input_file.readlines
  input_lines.each do |line|
    if line.include?(',')
      coord_lines.append(line)
    elsif line.include?('fold along')
      fold_lines.append(line)
    end
  end

  grid = Grid.new

  coord_lines.each do |coord_line|
    coords = coord_line.split(',').map(&:to_i)
    grid.add_point(coords[0], coords[1])
  end

  pp "There are #{grid.points.length} points in the grid"

  fold_lines.each do |fold_line|
    fold = fold_line.split[2].split('=')

    case fold[0]
    when 'x'
      grid.fold_x(fold[1].to_i)
    when 'y'
      grid.fold_y(fold[1].to_i)
    end

    pp "After fold, there are #{grid.points.length} unique points in the grid"
  end

  grid.grid_array.each do |row|
    row.each do |cell|
      print cell
    end
    print "\n"
  end
end
