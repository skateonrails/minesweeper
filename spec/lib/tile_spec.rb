# frozen_string_literal: true

require 'spec_helper'

describe Tile do
  let(:board) { double('board') }
  let(:adjacent_tile) { Tile.new(board: board) }
  subject { Tile.new(board: board) }

  describe '#initialize' do
    it 'should start as a "hidden" tile' do
      expect(subject.hidden).to be true
    end

    it 'should start without flag mark' do
      expect(subject.has_flag).to be false
    end

    it 'should start with zero adjacent bombs count' do
      expect(subject.adjacent_bombs_count).to eq(0)
    end

    it 'should start without mine set on tile' do
      expect(subject.has_mine).to be false
    end

    it 'should start without any adjacent tile' do
      expect(subject.adjacent_tiles).to be_empty
    end
  end

  describe '#increase_adjacent_bombs_count' do
    it 'should increase adjacent_bombs_count by 1' do
      subject.increase_adjacent_bombs_count
      expect(subject.adjacent_bombs_count).to eq(1)
    end
  end

  describe '#toggle_flag' do
    context 'with "hidden" tile' do
      it 'should toggle value for has_flag' do
        expect(subject.toggle_flag).to be true
        expect(subject.has_flag).to be true

        expect(subject.toggle_flag).to be true
        expect(subject.has_flag).to be false
      end
    end

    context 'without "hidden" tile' do
      it 'should return false' do
        allow(subject).to receive(:hidden).and_return(false)
        expect(subject.toggle_flag).to be false
        expect(subject.has_flag).to be false
      end
    end
  end

  describe '#add_adjacent_tile' do
    let(:double_tile) { double('tile', add_adjacent_tile: nil) }

    it 'should add a tile to adjacent tiles list' do
      subject.add_adjacent_tile(double_tile)
      expect(subject.adjacent_tiles).to include(double_tile)
    end

    it 'should call add_adjacent_tile for tile passed as argument, sending self' do
      expect(double_tile).to receive(:add_adjacent_tile).with(subject).and_return(true)
      subject.add_adjacent_tile(double_tile)
    end
  end

  describe '#place_mine' do
    context 'without mine placed' do
      it 'should set has_mine to true' do
        subject.place_mine
        expect(subject.has_mine).to be true
      end

      it 'should update adjacent_bombs_count to adjacent tiles' do
        subject.add_adjacent_tile(adjacent_tile)
        subject.place_mine
        expect(adjacent_tile.adjacent_bombs_count).to eq(1)
      end
    end

    context 'with mine placed' do
      it 'should raise error' do
        allow(subject).to receive(:has_mine).and_return(true)
        expect { subject.place_mine }.to raise_error(MineAlreadyPlacedError)
      end

      it 'should not update adjacent_bombs_count to adjacent tiles' do
        subject.add_adjacent_tile(adjacent_tile)
        allow(subject).to receive(:has_mine).and_return(true)

        expect { subject.place_mine }.to raise_error(MineAlreadyPlacedError)
        expect(adjacent_tile.adjacent_bombs_count).to eq(0)
      end
    end
  end

  describe '#show' do
    context 'with a flag' do
      it 'should not show tile' do
        allow(subject).to receive(:has_flag).and_return(true)
        subject.show
        expect(subject.hidden).to be true
      end
    end

    context 'with a mine' do
      it 'should not show tile' do
        allow(subject).to receive(:has_mine).and_return(true)
        subject.show
        expect(subject.hidden).to be true
      end
    end

    context 'tile does not has a flag, still hidden and does not has a mine' do
      it 'show tile and call #valid_tile_discovered on board' do
        expect(board).to receive(:valid_tile_discovered)
        subject.show
        expect(subject.hidden).to be false
      end
    end
  end

  describe '#click' do
    context 'with "hidden" tile' do
      it 'should "show" tile' do
        subject.click
        expect(subject.hidden).to be false
      end

      it 'should return true' do
        expect(subject.click).to be true
      end

      it 'should call #show for adjacent tiles' do
        expect(adjacent_tile).to receive(:show).once

        subject.add_adjacent_tile(adjacent_tile)
        subject.click
      end
    end

    context 'without "hidden" tile' do
      it 'should return false' do
        allow(subject).to receive(:hidden).and_return(false)
        expect(subject.click).to be false
      end
    end

    context 'with has_flag as false' do
      it 'should return true' do
        expect(subject.click).to be true
      end
    end

    context 'with has_flag as true' do
      it 'should return false' do
        allow(subject).to receive(:has_flag).and_return(true)
        expect(subject.click).to be false
      end
    end

    context 'with a mine on tile' do
      it 'should terminate game' do
        allow(subject).to receive(:has_mine).and_return(true)
        expect(board).to receive(:mine_clicked)
        subject.click
      end
    end
  end
end
