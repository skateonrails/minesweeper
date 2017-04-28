# frozen_string_literal: true

# PrettyPrinter is responsible to print board_state in a pretier way
class PrettyPrinter
  TILE_FORMAT = {
    hidden: '.',
    clear: ' ',
    mine: '#',
    flag: 'F'
  }.freeze

  class << self
    # :reek:NestedIterators
    def print(matrix)
      mapping = matrix.to_a.map do |row|
        row.map { |tile| TILE_FORMAT[tile.tile_state] }.join('|')
      end
      puts mapping
    end
  end
end
