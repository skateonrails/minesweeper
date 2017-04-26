# frozen_string_literal: true

require 'matrix'
require 'tile'
# Board class is responsible to create a matrix of tiles
class Board
  attr_reader :width, :height, :mine_count

  def initialize(width:, height:, mine_count:)
    @width = width
    @height = height
    @mine_count = mine_count

    create_matrix
    set_mines
  end

  def click_tile(x_axis:, y_axis:)
    tile(x_axis, y_axis).click
  end

  def flag_tile(x_axis:, y_axis:)
    tile(x_axis, y_axis).toggle_flag
  end

  private

  attr_reader :grid

  def create_matrix
    @grid = Matrix.build(width, height) { Tile.new }
  end

  def set_mines
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
