require 'spec_helper'

describe TopPointDetection do
  let(:number_of_points) { 0 }
  let(:window_width) { 2 }
  let(:give_up_after) { 10 }
  let(:collection_count) { 3 }

  let(:data) { load_test_input.first(number_of_points) }
  subject { described_class.new(data) }

  context 'top point detection' do
    before { subject.run(window_width, give_up_after, collection_count) }

    context 'finds top points' do
      COUNT_START_POSITION = {
        8 => [5],
        11 => [5],
        12 => [5,10],
        20 => [5,10,17],
        25 => [5,10,17,22],
      }

      COUNT_START_POSITION.each do |c, p|
        context "with the first #{c} points" do
          let(:number_of_points) { c }
          let(:samples) { p.map {|i| data[i-1] } }
          it { expect(subject.high_points).to eq(samples) }
        end
      end
    end
  end

  context 'top point collections' do
    before { subject.run(window_width, give_up_after, collection_count) }

    context 'finds top points' do
      COUNT_START_POSITION = {
        8 => [],
        11 => [],
        12 => [],
        20 => [[5,10,17]],
        25 => [[5,10,17]],
      }

      COUNT_START_POSITION.each do |c, p|
        context "with the first #{c} points" do
          let(:number_of_points) { c }
          let(:samples) { p.map {|a| a.map {|i| data[i-1] }} }
          it { expect(subject.collections).to eq(samples) }
        end
      end
    end
  end
end
