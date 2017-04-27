# frozen_string_literal: true

# BoardHelper is a module that has some helper methods for Board
module BoardHelper
  def self.set_adjacent_tiles(grid:, row:, col:)
    element = grid[row, col]

    coordinates(row, col).each do |coordinate_row, coordinate_col|
      adjacent_tile = grid[coordinate_row, coordinate_col]
      next if !adjacent_tile ||
              (coordinate_row.negative? || coordinate_col.negative?)

      element.add_adjacent_tile(adjacent_tile)
    end
  end

  def self.coordinates(row, col)
    previous_row = row - 1
    next_row = row + 1
    previous_col = col - 1
    [
      [previous_row, previous_col],
      [row, previous_col],
      [next_row, previous_col],
      [previous_row, col],
      [next_row, col]
    ]
  end
  private_class_method :coordinates
end
