# frozen_string_literal: true

require 'spec_helper'

describe Minesweeper do
  subject { Minesweeper }

  let(:width) { 10 }
  let(:height) { 10 }
  let(:mines) { 20 }

  describe '#initialize' do
    it 'should create a board' do
      expect(Board).to receive(:new).with(width: width, height: height, mine_count: mines)
      subject.new(width: width, height: height, mines: mines)
    end
  end
end
