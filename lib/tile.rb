# frozen_string_literal: true

require 'exceptions'
# Tile class is responsible to represent a tile
# on minesweeper game
class Tile
  attr_reader :hidden, :has_flag, :adjacent_bombs_count,
              :has_mine, :adjacent_tiles

  def initialize(board:)
    @hidden = true
    @has_flag = false
    @adjacent_bombs_count = 0
    @has_mine = false
    @adjacent_tiles = []
    @board = board
  end

  def click
    return false unless can_show?
    show_tile
    board.mine_clicked if has_mine
    true
  end

  def show
    show_tile && board.valid_tile_discovered if can_show? && !has_mine
  end

  def toggle_flag
    return false unless hidden
    self.has_flag = !has_flag
    true
  end

  def place_mine
    raise MineAlreadyPlacedError if has_mine
    self.has_mine = true
    update_adjacent_bombs_count
  end

  def add_adjacent_tile(tile)
    return if adjacent_tiles.include?(tile)
    adjacent_tiles << tile
    tile.add_adjacent_tile(self)
  end

  def increase_adjacent_bombs_count
    self.adjacent_bombs_count += 1
  end

  private

  attr_reader :board
  attr_writer :hidden, :has_flag, :has_mine, :adjacent_bombs_count

  def can_show?
    !has_flag && hidden
  end

  def show_tile
    self.hidden = false
    show_adjacent_tiles
  end

  def update_adjacent_bombs_count
    adjacent_tiles.each(&:increase_adjacent_bombs_count)
  end

  def show_adjacent_tiles
    adjacent_tiles.each(&:show)
  end
end
