require 'spec_helper'

describe Calculate do
  let(:p1) { Point.new(400.0, 300.0) }
  let(:p2) { Point.new(300.0, 400.0) }

  context '#angle' do
    it { expect(Calculate.angle(400.0, 300.0).round).to eq(37) }
  end

  context '#angle using a Point 1' do
    it { expect(Calculate.angle(p1).round).to eq(37) }
  end

  context '#angle using a Point 2' do
    it { expect(Calculate.angle(p2).round).to eq(53) }
  end

  context '#diff' do
    it { expect(Calculate.diff(p1, p2).round).to eq(16) }
  end

  context '#project' do
    subject { Calculate.project(start_point, steps, angle, points) }

    let(:data) { load_test_input }
    let(:points) { data[0..steps] }
    let(:start_point) { data[0].to_point }

    let(:angle) { 5 }
    let(:steps) { 3 }

    let(:result) do
      [
        [data[0].chart_date, 3.0],
        [data[1].chart_date, 3.262465990577772],
        [data[2].chart_date, 3.524931981155544]
      ]
    end

    it 'creates a line from a start point and an angle' do
      expect(subject.to_s).to eq(result.to_s)
    end
  end
end
