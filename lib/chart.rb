require 'gruff'

class Chart
  attr_reader :graph

  def initialize(type: :line, title: nil, size: Gruff::Base::DEFAULT_TARGET_WIDTH)
    create(:line, size)
    title(title) unless title.nil?
    graph.hide_dots = true
  end

  def title(text)
    graph.title = text
  end

  def labels(_labels, _number_of_points = _labels.count)
    graph.labels = create_labels(_labels, _number_of_points)
  end

  # g.data :Jimmy, [25, 36, 86, 39, 25, 31, 79, 88]
  # g.write('exciting.png')
  def method_missing(meth, *args, &block)
    graph.public_send(meth, *args)
  end

  private

  def create(type, size)
    @graph = Gruff::Line.new(size)
  end

  def create_labels(_labels, _number_of_points)
    space = (_labels.count-2) / _number_of_points
    {}.tap do |hash|
      hash[0] = _labels.first
      _labels[0.._labels.count-1].each_with_index do |label, index|
        if index > space && index < _labels.count
          hash[index] = label
          space += space
        end
      end
      hash[_labels.count-1] = _labels.last
    end
  end
end
