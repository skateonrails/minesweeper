# frozen_string_literal: true

require 'spec_helper'

describe Board do
  subject { Board }

  let(:width) { 10 }
  let(:height) { 10 }
  let(:mine_count) { 20 }
  let(:board) { subject.new(width: width, height: height, mine_count: mine_count) }

  describe '#initialize' do
    it 'should receive width, height and number of mines' do
      expect(board.width).to eq(width)
      expect(board.height).to eq(height)
      expect(board.mine_count).to eq(mine_count)
    end

    it 'should place an amount of mines equal to the mine_count parameter' do
      tile = double('tile')
      allow_any_instance_of(Board).to receive(:tile).and_return(tile)

      expect(tile).to receive(:place_mine).at_least(mine_count).times
      board
    end

    it 'should set adjacent tiles for each tile' do
      board.grid.each do |tile|
        expect(tile.adjacent_tiles.size).to be >= 3
        expect(tile.adjacent_tiles.size).to be <= 8
      end
    end
  end

  describe '#click_tile' do
    it 'should call click on tile' do
      expect_any_instance_of(Tile).to receive(:click).at_least :once
      board.click_tile(x_axis: 0, y_axis: 0)
    end
  end

  describe '#flag_tile' do
    it 'should call toggle_flag on tile' do
      expect_any_instance_of(Tile).to receive(:toggle_flag)
      board.flag_tile(x_axis: 0, y_axis: 0)
    end
  end
end
