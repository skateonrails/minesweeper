require 'spec_helper'

describe Minesweeper do
  subject { Minesweeper }

  let(:width) { 10 }
  let(:height) { 10 }
  let(:mines) { 20 }
  let(:game) { subject.new(width: width, height: height, mines: mines) }

  describe '#initialize' do
    it 'should receive width, height and number of mines' do
      expect(game.width).to eq(width)
      expect(game.height).to eq(height)
      expect(game.mines).to eq(mines)
    end
  end
end
