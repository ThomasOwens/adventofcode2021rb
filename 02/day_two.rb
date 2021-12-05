# frozen_string_literal: true

# https://adventofcode.com/2021/day/2

class Submarine
  attr_reader :depth, :horizontal_position

  def initialize
    @depth = 0
    @horizontal_position = 0
  end

  def move(command)
    if 'forward'.casecmp?(command[0])
      move_forward(command[1].to_i)
    elsif 'down'.casecmp?(command[0])
      move_down(command[1].to_i)
    elsif 'up'.casecmp?(command[0])
      move_up(command[1].to_i)
    end
  end

  private

    def move_forward(distance)
      @horizontal_position += distance
    end

    def move_up(distance)
      @depth -= distance
    end

    def move_down(distance)
      @depth += distance
    end
end

class AimingSubmarine < Submarine
  attr_reader :aim

  def initialize
    super
    @aim = 0
  end

  def move(command)
    if 'forward'.casecmp?(command[0])
      move_forward(command[1].to_i)
    elsif 'down'.casecmp?(command[0])
      aim_down(command[1].to_i)
    elsif 'up'.casecmp?(command[0])
      aim_up(command[1].to_i)
    end
  end
  
  private

    def move_forward(distance)
      @horizontal_position += distance
      @depth += aim * distance
    end

    def aim_up(amount)
      @aim -= amount
    end

    def aim_down(amount)
      @aim += amount
    end
end

if $PROGRAM_NAME == __FILE__
  raise ArgumentError, 'Missing or invalid input file.' unless File.file?(ARGV[0]) && File.readable?(ARGV[0])

  submarine = Submarine.new
  aiming_submarine = AimingSubmarine.new
  File.foreach(File.new(ARGV[0])) do |line|
    movement_command = line.split
    submarine.move(movement_command)
    aiming_submarine.move(movement_command)
  end

  puts "Part 1: #{submarine.horizontal_position * submarine.depth}" # Expected: 1990000
  puts "Part 2: #{aiming_submarine.horizontal_position * aiming_submarine.depth}" # Expected: 1975421260
end
