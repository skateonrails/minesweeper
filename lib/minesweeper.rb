# frozen_string_literal: true

# Minesweeper class is responsible to control the game flow
class Minesweeper
  def initialize(width, height, mines)
    @board = Board.new(width: width,
                       height: height,
                       mine_count: mines,
                       minesweeper: self)
    @state = :playing
  end

  def play(x_axis, y_axis)
    board.click_tile(x_axis: x_axis, y_axis: y_axis)
  end

  def flag(x_axis, y_axis)
    board.flag_tile(x_axis: x_axis, y_axis: y_axis)
  end

  def mine_clicked
    self.state = :lose
  end

  def victory
    self.state = :win
  end

  def victory?
    state == :win
  end

  def still_playing?
    state == :playing
  end

  def board_state(args = {})
    xray = args.fetch(:xray, false)
    parameter = xray && !still_playing?
    board.current_state(xray: parameter)
  end

  private

  attr_reader :board
  attr_accessor :state
end
