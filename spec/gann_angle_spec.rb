require 'spec_helper'

describe GannAngle do
  let(:days_before_startpoint) { 3 }
  let(:a_b_window) { 5 }

  let(:data) { load_test_input('gann_data.csv').first(number_of_points) }
  subject { described_class.new(data) }

  before { subject.run(days_before_startpoint, a_b_window) }

  context 'finds p1' do
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

  describe 'calcs' do
    let(:number_of_points) { 19 }
    let(:alpha) { 0.5454545454545454 }
    let(:beta) { 0.3370909090909091 }
    let(:gamma) { 0.20836363636363633 }
    let(:mid) { 0.2727272727272727 }
    let(:low) { 0.12872727272727275 }

    context 'returns stuff in an hash' do
      let(:result) { { data[3] => {alpha: alpha, beta: beta, gamma: gamma, mid: mid, low: low, x: 11} } }
      it { expect(subject.angles).to eq(result) }
    end
  end
end
