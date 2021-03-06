# frozen_string_literal: true

require 'spec_helper'

describe Minesweeper do
  let(:width) { 10 }
  let(:height) { 10 }
  let(:mines) { 20 }

  subject { Minesweeper.new(width, height, mines) }

  describe '#initialize' do
    it 'should create a board' do
      params = { width: width,
                 height: height,
                 mine_count: mines,
                 minesweeper: anything }
      expect(Board).to receive(:new).with(params)
      subject
    end
  end

  describe '#play' do
    it 'should receive x_axis and y_axis and click to a tile on board' do
      expect_any_instance_of(Board).to receive(:click_tile).and_return true
      subject.play(rand(width), rand(height))
    end
  end

  describe '#flag' do
    it 'should receive x_axis and y_axis and flag a tile on board' do
      expect_any_instance_of(Board).to receive(:flag_tile).and_return true
      subject.flag(rand(width), rand(height))
    end
  end

  describe '#mine_clicked' do
    before :each do
      subject.mine_clicked
    end

    context 'checking victory' do
      it 'should return false' do
        expect(subject.victory?).to be false
      end
    end

    context 'checking if still playing' do
      it 'should return false' do
        expect(subject.still_playing?).to be false
      end
    end
  end

  describe '#victory' do
    before :each do
      subject.victory
    end

    context 'checking victory' do
      it 'should return true' do
        expect(subject.victory?).to be true
      end
    end

    context 'checking if still playing' do
      it 'should return false' do
        expect(subject.still_playing?).to be false
      end
    end
  end

  describe '#board_state' do
    context 'xray as false' do
      it 'should call #current_state on board' do
        expect_any_instance_of(Board).to receive(:current_state).with(xray: false)
        subject.board_state
      end
    end

    context 'xray as true' do
      context 'with game not finished' do
        it 'should call #current_state on board with false parameter' do
          expect_any_instance_of(Board).to receive(:current_state).with(xray: false)
          subject.board_state(xray: true)
        end
      end

      context 'with game finished' do
        it 'should call #current_state on board with true parameter' do
          allow(subject).to receive(:still_playing?).and_return(false)
          expect_any_instance_of(Board).to receive(:current_state).with(xray: true)
          subject.board_state(xray: true)
        end
      end
    end
  end
end
