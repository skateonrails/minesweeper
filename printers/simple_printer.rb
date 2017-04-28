# frozen_string_literal: true

# SimplePrinter is responsible to print board_state in a basic/simple way
class SimplePrinter
  def initialize
    @current_row = nil
  end

  # :reek:NestedIterators
  def print(matrix)
    mapping = matrix.to_a.map do |row|
      self.current_row = row
      format_row
    end
    puts mapping
  end

  private

  attr_accessor :current_row

  def format_row
    current_row.map(&:tile_state).join(' | ')
  end
end
