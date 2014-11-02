require 'spec_helper'

describe GannAngle do
  let(:days_before_startpoint) { 4 }

  let(:data) { load_test_input('gann_data.csv').first(number_of_points) }
  subject { described_class.new(data) }

  before { subject.run(days_before_startpoint) }

  context 'finds crossover point' do
    let(:number_of_points) { 6 }
    it { expect(subject.start_point).to eq(data[3]) }
  end
end
