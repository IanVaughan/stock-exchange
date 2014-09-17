require 'spec_helper'

describe Analiser do
  subject { described_class.new(load_test_input.first(count)) }

  let(:start_point) { subject.points[startp-1] }
  let(:end_point) { subject.points[endp-1] }

  context 'not yielding' do
    before { subject.run }

    context 'tracking the start point (p1)' do
      COUNT_START_POSITION = {
        5 => 4,
        6 => 4,
        7 => 5,
        8 => 5,
        10 => 5,
        12 => 5,
        14 => 5,
        15 => 7,
        16 => 7,
        17 => 7,
        18 => 7,
      }

      COUNT_START_POSITION.each do |c, p|
        context "with the first #{c} points" do
          let(:count) { c }
          it { expect(subject.start_point).to eq(subject.points[p-1]) }
        end
      end
    end

    context 'tracking the end point (p2)' do
      COUNT_END_POSITION = {
        5 => 5,
        6 => 5,
        7 => 7,
        8 => 7,
        14 => 7,
        15 => 15,
        16 => 15,
        17 => 17,
        18 => 17,
      }

      COUNT_END_POSITION.each do |c, p|
        context "with the first #{c} points" do
          let(:count) { c }
          it { expect(subject.end_point).to eq(subject.points[p-1]) }
        end
      end
    end

    context 'trends' do
      TREND_COUNT_START_END = {
         6 => [4, 5], # T1
         10 => [5, 7], # T2
         15 => [7, 15], # T3
         18 => [7, 17], # T4
         # 20d ma dropped
         21 => [20, 21], # AB
         22 => [20, 22], # AC
      }

      TREND_COUNT_START_END.each do |c, p|
        context "At position #{c} it creates a trend line between points #{p.first} and #{p.last}" do
          let(:count) { c }
          let(:startp) { p.first }
          let(:endp) { p.last }
          it { expect(subject.trend.to_a).to eq([start_point, end_point]) }
        end
      end
    end
  end

  context 'yielding trends' do
    context 'yields each trend' do
      let(:count) { 7 }

      it 'yields each trend' do
        expect { |b| subject.run(&b) }.to yield_control.exactly(2).times
      end

      def point(x)
        subject.points[x-1]
      end

      let(:trends) do
        [
          Trend.new(point(4), point(5)).to_a,
          Trend.new(point(5), point(7)).to_a,
          Trend.new(point(7), point(15)).to_a,
          Trend.new(point(7), point(17)).to_a,
        ]
      end

      it 'yields the trends' do
        expect { |b| subject.run(&b) }.to yield_successive_args(trends[0], trends[1])
      end
    end
  end
end
