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
    let(:start_point) { Point.new(5, 5) }
    let(:end_point) { Point.new(15, 0.8748866352592395) }

    let(:angle) { 5 }
    let(:length) { 10 }
    # let(:diff) { 4.5874886635259235 }

    let(:result) do
      [
        Point.new(5, 5.0),
        Point.new(6, 5.087488663525924),
        Point.new(7, 5.174977327051848),
        Point.new(8, 5.2624659905777715),
        Point.new(9, 5.349954654103696),
        Point.new(10, 5.43744331762962),
        Point.new(11, 5.524931981155544),
        Point.new(12, 5.6124206446814675),
        Point.new(13, 5.699909308207392),
        Point.new(14, 5.787397971733316)
      ]
    end

    it 'creates a line from a start point and an angle' do
      expect(Calculate.project(start_point, length, angle).to_s).to eq(result.to_s)
    end
  end
end
