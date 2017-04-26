# frozen_string_literal: true

require 'spec_helper'

describe Tile do
  subject { Tile.new }

  describe '#initialize' do
    it 'should start as a "hidden" tile' do
      expect(subject.hidden).to be true
    end

    it 'should start without flag mark' do
      expect(subject.has_flag).to be false
    end

    it 'should start without adjacent bombs count' do
      expect(subject.adjacent_bombs_count).to eq(0)
    end

    it 'should start without mine set on tile' do
      expect(subject.has_mine).to be false
    end
  end

  describe '#toggle_flag' do
    it 'should toggle value for has_flag' do
      subject.toggle_flag
      expect(subject.has_flag).to be true

      subject.toggle_flag
      expect(subject.has_flag).to be false
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
  end

  describe '#place_mine' do
    context 'without mine placed' do
      it 'should set has_mine to true' do
        subject.place_mine
        expect(subject.has_mine).to be true
      end
    end

    context 'with mine placed' do
      it 'should raise error' do
        allow(subject).to receive(:has_mine).and_return(true)
        expect { subject.place_mine }.to raise_error(MineAlreadyPlacedError)
      end
    end
  end
end
