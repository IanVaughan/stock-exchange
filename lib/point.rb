class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def first
    x
  end

  def last
    y
  end

  def to_s
    "x:#{x}, y:#{y}"
  end
end

