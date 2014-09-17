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
end
