# frozen_string_literal: true

require 'board'
# Minesweeper class is responsible to control the game flow
class Minesweeper
  def initialize(width:, height:, mines:)
    @board = Board.new(width: width, height: height, mine_count: mines)
  end

  private

  attr_reader :board
end
