# frozen_string_literal: true

# Minesweeper class is responsible to control the game flow
class Minesweeper
  attr_reader :width, :height, :mines

  def initialize(width:, height:, mines:)
    @width = width
    @height = height
    @mines = mines
  end
end
