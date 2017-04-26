# frozen_string_literal: true

require 'exceptions'
# Tile class is responsible to represent a tile
# on minesweeper game
class Tile
  attr_reader :hidden, :has_flag, :adjacent_bombs_count,
              :has_mine

  def initialize
    @hidden = true
    @has_flag = false
    @adjacent_bombs_count = 0
    @has_mine = false
  end

  def click
    return false if has_flag || !hidden
    show_tile
    true
  end

  def toggle_flag
    return false unless hidden
    self.has_flag = !has_flag
    true
  end

  def place_mine
    raise MineAlreadyPlacedError if has_mine
    self.has_mine = true
  end

  private

  attr_writer :hidden, :has_flag, :has_mine

  def show_tile
    self.hidden = false
  end
end
