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

    if tracking? && found_start_point && found_end_point
      update_start_point
      @trend = [start_point, end_point]
      @end_latched = false
      yield @trend if block_given?
    end
  end

  def tracking?
    p.mov_avg_20d >= p.mov_avg_50d
  end

  def found_start_point
    return true if @start_latched

    @start_point ||= p

    if p.px_high >= start_point.px_high
      @start_point = p
    else
      @start_latched = true
    end
    return @start_latched
  end

  def found_end_point
    return true if @end_latched

    @end_point ||= p

    if p.px_high >= start_point.px_high && p.px_high > end_point.px_high
      @end_point = p
      @end_latched = true
    end

    return @end_latched
  end

  def update_start_point
    return start_point if @trend.nil?

    current_trend_diff = trend.last.px_high - trend.first.px_high
    new_trend_diff = end_point.px_high - trend.last.px_high
    if new_trend_diff < current_trend_diff
      @start_point = trend.last
    end
  end
end
