# frozen_string_literal: true

# TileHelper is a module that has some helper methods for Tile
module TileHelper
  def self.current_state(args)
    tile = args.fetch(:tile)
    xray = args.fetch(:xray, false)

    if tile.hidden
      return xray_hidden_state(tile) if xray
      return hidden_state(tile)
    end
    visible_state(tile)
  end

  def self.hidden_state(tile)
    return :flag if tile.has_flag
    :hidden
  end
  private_class_method :hidden_state

  def self.xray_hidden_state(tile)
    return :flag if tile.has_flag
    return :mine if tile.has_mine
    :clear
  end
  private_class_method :xray_hidden_state

  def self.visible_state(tile)
    adjacent_bombs_count = tile.adjacent_bombs_count
    return :mine if tile.has_mine
    return :clear if adjacent_bombs_count.zero?
    adjacent_bombs_count
  end
  private_class_method :visible_state
end
