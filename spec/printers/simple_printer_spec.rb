# frozen_string_literal: true

require 'spec_helper'
require 'matrix'
require 'ostruct'

describe SimplePrinter do
  subject { SimplePrinter.new }
  let(:matrix) { Matrix.build(3, 3) { OpenStruct.new(tile_state: :hidden) } }
  let(:expected_output) do
    <<~OUTPUT
      hidden | hidden | hidden
      hidden | hidden | hidden
      hidden | hidden | hidden
    OUTPUT
  end

  describe '::print' do
    it 'should receive a matrix and print it' do
      expect { subject.print(matrix) }.to output(expected_output).to_stdout
    end
  end
end
