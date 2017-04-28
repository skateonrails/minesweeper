# frozen_string_literal: true

require 'spec_helper'
require 'matrix'
require 'ostruct'

describe PrettyPrinter do
  subject { PrettyPrinter }
  let(:tile_state) { nil }
  let(:matrix) { Matrix.build(3, 3) { OpenStruct.new(tile_state: tile_state) } }

  describe '::print' do
    context 'with hidden tiles' do
      let(:tile_state) { :hidden }
      let(:expected_output) { ".|.|.\n.|.|.\n.|.|.\n" }

      it 'should receive a matrix and print it' do
        expect { subject.print(matrix) }.to output(expected_output).to_stdout
      end
    end

    context 'with clear tiles' do
      let(:tile_state) { :clear }
      let(:expected_output) { " | | \n | | \n | | \n" }

      it 'should receive a matrix and print it' do
        expect { subject.print(matrix) }.to output(expected_output).to_stdout
      end
    end

    context 'with flag tiles' do
      let(:tile_state) { :flag }
      let(:expected_output) { "F|F|F\nF|F|F\nF|F|F\n" }

      it 'should receive a matrix and print it' do
        expect { subject.print(matrix) }.to output(expected_output).to_stdout
      end
    end

    context 'with mine tiles' do
      let(:tile_state) { :mine }
      let(:expected_output) { "#|#|#\n#|#|#\n#|#|#\n" }

      it 'should receive a matrix and print it' do
        expect { subject.print(matrix) }.to output(expected_output).to_stdout
      end
    end
  end
end
