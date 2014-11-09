require 'spec_helper'

describe GannAngle do
  let(:days_before_startpoint) { 3 }
  let(:a_b_window) { 5 }

  let(:data) { load_test_input('gann_data.csv').first(number_of_points) }
  subject { described_class.new(data) }

  before { subject.run(days_before_startpoint, a_b_window) }

  context 'finds crossover point' do
    let(:number_of_points) { 6 }
    it { expect(subject.start_point).to eq(data[3]) }
  end

  context 'finds point A' do
    let(:number_of_points) { 6 }
    it { expect(subject.point_a).to eq(data[1]) }
  end

  context 'finds crossback point' do
    let(:number_of_points) { 19 }
    it { expect(subject.end_point).to eq(data[18]) }
  end

  context 'finds point B' do
    let(:number_of_points) { 19 }
    it { expect(subject.point_b).to eq(data[12]) }
  end

  context 'calcs stuff' do
    let(:number_of_points) { 19 }
    it { expect(subject.alpha).to eq(0.5454545454545454) }
    it { expect(subject.beta).to eq(0.3370909090909091) }
    it { expect(subject.gamma).to eq(0.20836363636363633) }
  end
end
