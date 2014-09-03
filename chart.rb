require 'gruff'

class Chart
  attr_reader :graph

  def initialize
  end

  def line(title: nil, size: Gruff::Base::DEFAULT_TARGET_WIDTH)
    @graph = Gruff::Line.new(size)
    title(title) unless title.nil?
    self
  end

  def title text
    graph.title = text
    self
  end

  def labels _labels
    graph.labels = {}.tap { |h| _labels.each_with_index { |l,i| h[i] = l } }
    self
  end

  # g.data :Jimmy, [25, 36, 86, 39, 25, 31, 79, 88]
  def data _label, _data
    graph.data _label, _data
    self
  end

  # g.write('exciting.png')
  def create name
    graph.write(name)
  end
end
