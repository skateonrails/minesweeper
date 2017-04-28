# frozen_string_literal: true

# SimplePrinter is responsible to print board_state in a basic/simple way
class SimplePrinter
  class << self
    # :reek:NestedIterators
    def print(matrix)
      mapping = matrix.to_a.map do |row|
        row.map(&:tile_state).join(' | ')
      end
      puts mapping
    end
  end
end
