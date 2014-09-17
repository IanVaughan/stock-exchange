class Analiser
  attr_reader :points, :start_point, :end_point, :trend

  def initialize(points)
    @points = points
  end

  def run(&block)
    points.each { |p| analise(p, &block) }
  end

  private

  attr_accessor :p

  def analise(p, &block)
    @p = p

    if tracking?
      if found_start_point? && found_end_point?
        @trend = Trend.new(start_point, end_point)
        @end_latched = false
      end
    else
      if @trend && @start_latched
        yield @trend.to_a if block_given?
      end

      @start_latched = false
      @end_latched = false
      @start_point = nil
      @end_point = nil
      @trend = nil
    end
  end

  def tracking?
    p.mov_avg_20d >= p.mov_avg_50d
  end

  def found_start_point?
    return true if @start_latched

    @start_point = p
    @start_latched = true

    return @start_latched
  end

  def found_end_point?
    return true if @end_latched
    return false if p == start_point

    @end_point ||= p

    if p.px_high >= start_point.px_high && p.px_high >= end_point.px_high
      @end_point = p
      @end_latched = true
    end

    return @end_latched
  end

  def update_start_point
    return start_point if @trend.nil?

    p1 = trend.diff
    p2 = end_point - trend.end_point
    t1 = Calculate.diff(p1, p2)

    if t1 < -1.0
      @start_point = trend.end_point
    end
  end
end
