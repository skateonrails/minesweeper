# frozen_string_literal: true

require 'matrix'
require 'tile'
require_relative 'helpers/board_helper'
# Board class is responsible to create a matrix of tiles
class Board
  attr_reader :width, :height, :mine_count, :grid

  def initialize(width:, height:, mine_count:)
    @width = width
    @height = height
    @mine_count = mine_count

    create_matrix
    setup_adjacent_tiles
    setup_mines
  end

  def click_tile(x_axis:, y_axis:)
    tile(x_axis, y_axis).click
  end

  def flag_tile(x_axis:, y_axis:)
    tile(x_axis, y_axis).toggle_flag
  end

  private

  def create_matrix
    @grid = Matrix.build(width, height) { Tile.new }
  end

  def setup_adjacent_tiles
    grid.each_with_index do |_, row, col|
      BoardHelper.set_adjacent_tiles(grid: grid,
                                     row: row,
                                     col: col)
    end
  end

  def setup_mines
    mine_count.times do
      begin
        tile = tile(rand(width), rand(height))
        tile.place_mine
      rescue MineAlreadyPlacedError
        retry
      end
    end
  end

  def tile(x_axis, y_axis)
    grid[x_axis, y_axis]
  end
end
