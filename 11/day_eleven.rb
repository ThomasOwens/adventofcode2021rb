# frozen_string_literal: true

# https://adventofcode.com/2021/day/11

class DumboOctopuses
  def initialize(octopuses)
    @octopuses = octopuses
    @height = octopuses.length
    @length = octopuses.first.length
    @current_step = 0
    @step_flashes = {}
  end

  def step
    @current_step += 1
    @step_flashes[@current_step] = []
    increase_energy_levels
    octopuses_flash
  end

  def step_flashes
    @step_flashes.transform_values(&:length)
  end

  def total_flashes
    step_flashes.values.sum
  end

  private

    def increase_energy_levels
      @octopuses.map { |row| row.map!(&:succ) }
    end

    def octopuses_flash
      @octopuses.each_with_index do |row, row_index| 
        row.each_with_index do |_octopus, column_index|
          octopus_flash(row_index, column_index)
        end                                                    
      end      
    end

    def octopus_flash(row, column)
      return unless @octopuses[row][column] > 9
      
      @octopuses[row][column] = 0
      @step_flashes[@current_step].append([row, column])

      neighbors = [
        upper_neighbor(row, column),
        upper_right_neighbor(row, column),
        right_neighbor(row, column),
        lower_right_neighbor(row, column),
        lower_neighbor(row, column),
        lower_left_neighbor(row, column),
        left_neighbor(row, column),
        upper_left_neighbor(row, column)
      ]
      
      neighbors.each do |neighbor|
        next if neighbor.nil?

        unless @step_flashes[@current_step].include?([neighbor[:row], neighbor[:column]])
          @octopuses[neighbor[:row]][neighbor[:column]] += 1
        end
        octopus_flash(neighbor[:row], neighbor[:column])
      end
    end

    def upper_neighbor(row, column)
      return nil if (row - 1).negative?

      { row: row - 1, column: column, octopus: @octopuses[row - 1][column] }
    end

    def upper_right_neighbor(row, column)
      return nil if (row - 1).negative?
      return nil if (column + 1) >= @length

      { row: row - 1, column: column + 1, octopus: @octopuses[row - 1][column + 1] }
    end

    def right_neighbor(row, column)
      return nil if (column + 1) >= @length

      { row: row, column: column + 1, octopus: @octopuses[row][column + 1] }
    end

    def lower_right_neighbor(row, column)
      return nil if (row + 1) >= @height
      return nil if (column + 1) >= @length

      { row: row + 1, column: column + 1, octopus: @octopuses[row + 1][column + 1] }
    end

    def lower_neighbor(row, column)
      return nil if (row + 1) >= @height

      { row: row + 1, column: column, octopus: @octopuses[row + 1][column] }
    end

    def lower_left_neighbor(row, column)
      return nil if (row + 1) >= @height
      return nil if (column - 1).negative?

      { row: row + 1, column: column - 1, octopus: @octopuses[row + 1][column - 1] }
    end

    def left_neighbor(row, column)
      return nil if (column - 1).negative?

      { row: row, column: column - 1, octopus: @octopuses[row][column - 1] }
    end

    def upper_left_neighbor(row, column)
      return nil if (row - 1).negative?
      return nil if (column - 1).negative?

      { row: row - 1, column: column - 1, octopus: @octopuses[row - 1][column - 1] }
    end
end

if $PROGRAM_NAME == __FILE__
  input_file = File.new(ARGV[0])

  lines = input_file.readlines
  octopuses = DumboOctopuses.new(lines.map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) })
  Array.new(100).collect { octopuses.step }
  pp "Flashes after 100 Steps: #{octopuses.total_flashes}" # 1721

  input_file.seek(0)
  lines = input_file.readlines
  octopuses = DumboOctopuses.new(lines.map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) })
  octopuses.step while octopuses.step_flashes.values.last != 100
  pp "First step with synchronized flashes: #{octopuses.step_flashes.keys.last}" # 298
end
