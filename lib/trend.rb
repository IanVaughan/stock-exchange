class Trend
  attr_reader :start_point, :end_point

  def initialize start_point, end_point
    @start_point, @end_point = start_point, end_point
  end

  def diff
    end_point - start_point
  end

  def to_a
    [start_point, end_point]
  end
end
