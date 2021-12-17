# frozen_string_literal: true

# https://adventofcode.com/2021/day/17

class Probe
  attr_reader :path

  def initialize(x_velocity, y_velocity, target_area)
    @x_coord = 0
    @y_coord = 0
    @x_velocity = x_velocity
    @y_velocity = y_velocity
    @target_area = target_area
    @path = [[0, 0]]
  end

  def step
    @x_coord += @x_velocity
    @y_coord += @y_velocity
    @path.push([@x_coord, @y_coord])

    if @x_velocity.positive?
      @x_velocity -= 1
    elsif @x_velocity.negative?
      @x_velocity += 1
    end

    @y_velocity -= 1
  end

  def in_target_area?
    coordinate_in_target?(@x_coord, @y_coord)
  end

  def was_ever_in_target_area?
    @path.any? { |location| coordinate_in_target?(location[0], location[1]) } 
  end

  def beyond_target_area?
    @x_coord > @target_area[0][1] || @y_coord < @target_area[1][0]
  end

  private

    def coordinate_in_target?(x_coord, y_coord)
      x_coord >= @target_area[0][0] && x_coord <= @target_area[0][1] &&
        y_coord >= @target_area[1][0] && y_coord <= @target_area[1][1]
    end
end

if $PROGRAM_NAME == __FILE__
  input_file = File.new(ARGV[0])
  line = input_file.readline
  values = line.scan(/-?\d+/)
  target_area = [[values[0].to_i, values[1].to_i], [values[2].to_i, values[3].to_i]]

  maximum_x_velocity = target_area[0][1]
  maximum_y_velocity = target_area[1][0].abs

  valid_trajectories = []

  (0..maximum_x_velocity).each do |x_velocity|
    (-maximum_y_velocity..maximum_y_velocity).each do |y_velocity|
      probe = Probe.new(x_velocity, y_velocity, target_area)

      loop do
        probe.step
        break if probe.in_target_area? || probe.beyond_target_area?
      end

      valid_trajectories.push(probe.path) if probe.was_ever_in_target_area?
    end
  end

  pp "Highest Y Position: #{valid_trajectories.map { |trajectory| trajectory.max_by { |a| a[1] } }.max[1]}" # 15931
  pp "Distinct Initial Trajectories: #{valid_trajectories.length}" # 2555
end
