require 'spec_helper'

describe Analiser do
  subject { described_class.new(load_test_input.first(count)) }

  context 'no yield' do
    before { subject.run }

    context 'finding the start point' do
      let(:count) { 6 }
      let(:start_point) { Point.new(position: 5).to_h }
      it { expect(subject.start_point.to_h).to eq(start_point) }
    end

    context 'finding the end point' do
      let(:count) { 10 }
      let(:start_point) { Point.new(position: 5).to_h }
      let(:end_point) { Point.new(position: 7).to_h }
      it { expect(subject.start_point.to_h).to eq(start_point) }
      it { expect(subject.end_point.to_h).to eq(end_point) }
    end

    context 'creates T1' do
      let(:count) { 10 }
      let(:start_point) { Point.new(position: 5).to_h }
      let(:end_point) { Point.new(position: 7).to_h }
      it { expect(subject.trend.map(&:to_h)).to eq([start_point, end_point]) }
    end

    context 'creates T2' do
      let(:count) { 15 }
      let(:start_point) { Point.new(position: 7).to_h }
      let(:end_point) { Point.new(position: 15).to_h }
      it { expect(subject.trend.map(&:to_h)).to eq([start_point, end_point]) }
    end

    context 'creates T3' do
      let(:count) { 20 }
      let(:start_point) { Point.new(position: 7).to_h }
      let(:end_point) { Point.new(position: 17).to_h }
      it { expect(subject.trend.map(&:to_h)).to eq([start_point, end_point]) }
    end
  end

  context 'yield' do
    context 'yields each trend' do
      let(:count) { 20 }
      let(:t1) { [subject.points[4], subject.points[6]] }
      let(:t2) { [subject.points[6], subject.points[14]] }
      let(:t3) { [subject.points[6], subject.points[16]] }

      it 'yields each trend' do
        expect { |b| subject.run(&b) }.to yield_control.exactly(3).times
      end

      it 'yields the trends' do
        expect { |b| subject.run(&b) }.to yield_successive_args(t1, t2, t3)
      end
    end
  end
end
