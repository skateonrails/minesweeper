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
end
