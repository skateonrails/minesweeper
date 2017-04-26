# frozen_string_literal: true

# Tile class is responsible to represent a tile
# on minesweeper game
class Tile
  attr_reader :hidden, :has_flag, :adjacent_bombs_count

  def initialize
    @hidden = true
    @has_flag = false
    @adjacent_bombs_count = 0
  end

  def click
    return false if has_flag || !hidden
    show_tile
    true
  end

  def toggle_flag
    self.has_flag = !has_flag
  end

  private

  attr_writer :hidden, :has_flag

  def show_tile
    self.hidden = false
  end
end
