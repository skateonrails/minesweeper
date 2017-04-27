# frozen_string_literal: true

require 'spec_helper'

describe Board do
  let(:minesweeper) { double('minesweeper') }
  let(:width) { 10 }
  let(:height) { 10 }
  let(:mine_count) { 20 }

  subject do
    Board.new(width: width,
              height: height,
              mine_count: mine_count,
              minesweeper: minesweeper)
  end

  describe '#initialize' do
    it 'should place an amount of mines equal to the mine_count parameter' do
      tile = double('tile')
      allow_any_instance_of(Board).to receive(:tile).and_return(tile)

      expect(tile).to receive(:place_mine).at_least(mine_count).times
      subject
    end

    it 'should set adjacent tiles for each tile' do
      subject.grid.each do |tile|
        expect(tile.adjacent_tiles.size).to be >= 3
        expect(tile.adjacent_tiles.size).to be <= 8
      end
    end
  end

  describe '#click_tile' do
    it 'should call click on tile' do
      expect_any_instance_of(Tile).to receive(:click).at_least :once
      subject.click_tile(x_axis: 0, y_axis: 0)
    end
  end

  describe '#flag_tile' do
    it 'should call toggle_flag on tile' do
      expect_any_instance_of(Tile).to receive(:toggle_flag)
      subject.flag_tile(x_axis: 0, y_axis: 0)
    end
  end

  describe '#mine_clicked' do
    it 'should call finish_game on minesweeper object' do
      expect(minesweeper).to receive(:mine_clicked).and_return(true)
      subject.mine_clicked
    end
  end

  describe '#valid_tile_discovered' do
    it 'should decrease the tiles_remaining attribute' do
      previous_value = subject.tiles_remaining
      subject.valid_tile_discovered
      expect(subject.tiles_remaining).to eq(previous_value - 1)
    end

    context 'there are no tiles remaining' do
      it 'should call #victory on minesweeper' do
        allow(subject).to receive(:tiles_remaining).and_return(0)
        expect(minesweeper).to receive(:victory)

        subject.valid_tile_discovered
      end
    end
  end
end
