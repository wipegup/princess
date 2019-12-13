require 'pry'
require './lib/text_to_grid'
class Grid
  INVALID_GRID_ERROR = [ArgumentError, "Invalid Grid"]
  include TextToGrid
  attr_reader :array, :n
  def initialize(grid_info)
    raise ArgumentError, "Too many arguments" if grid_info.length > 1
    @solved = false
    @array = build_grid(grid_info)
    check_grid
  end

  def move(direction)
    case direction
    when "LEFT" then return shift(0,-1)
    when "RIGHT" then return shift(0,1)
    when "DOWN" then return shift(1,0)
    when "UP" then return shift(-1,0)
    end
  end

  def solved?
    @solved
  end

  def r
    array.index{|row| row.index('m')}
  end

  def c
    array[r].index('m')
  end

  private

  def shift(rows, cols)
    return false unless (0...n).include?(r + rows) && (0...n).include?(c + cols)

    new_r, new_c = [r + rows, c + cols]
    array[r][c] = '-'

    if array[new_r][new_c] == 'p'
      @solved = true
      array[new_r][new_c] = 'x'
    else
      array[new_r][new_c] = 'm'
    end

    return true
  end

  def build_grid(grid_info)
    return path_to_grid(grid_info[:path]) if grid_info[:path]
    return grid_info[:array] if grid_info[:array]
  end

  def check_grid
    raise(*INVALID_GRID_ERROR) unless array_contains('p')
    raise(*INVALID_GRID_ERROR) unless array_contains('m')
    raise(*INVALID_GRID_ERROR) unless square_array
  end

  def array_contains(char, number = 1)
    number == array.sum{|row| row.count(char)}
  end

  def square_array
    if array.all?{|row| row.length == @array[0].length} # Check row lengths
      @n = array[0].length
      return true if n == array.length # Check row length == num columns
    end

    return false
  end

end
