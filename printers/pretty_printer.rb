# frozen_string_literal: true

# PrettyPrinter is responsible to print board_state in a pretier way
class PrettyPrinter < SimplePrinter
  TILE_FORMAT = {
    hidden: '.',
    clear: ' ',
    mine: '#',
    flag: 'F'
  }.freeze

  private

  def format_row
    current_row.map { |tile| TILE_FORMAT[tile.tile_state] }.join('|')
  end
end
