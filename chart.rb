require 'gruff'

class Chart
  attr_reader :graph

  def initialize(type: :line, title: nil, size: Gruff::Base::DEFAULT_TARGET_WIDTH)
    title(title) unless title.nil?
    create(:line, size)
  end

  def title(text)
    graph.title = text
  end

  def labels(_labels, _number_of_points = _labels.count)
    graph.labels = create_labels(_labels)
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

  def create_labels(_labels)
    {}.tap do |hash|
      _labels.each_with_index { |label, i| hash[i] = label }
    end
  end
end
