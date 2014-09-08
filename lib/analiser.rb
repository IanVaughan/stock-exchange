class Analiser
  attr_reader :points, :start_point, :end_point, :best_trends

  def initialize(points)
    @points = points
    @end_point = points.first
    @trends = @best_trends = []
  end

  def run
    points.each { |p| analise(p) }
  end

  def analise(p)
    find_start_point(p)
    find_end_point(p)
  end

  def find_start_point(p)
    # start point : 20ma crosses 50ma
    # also moves start point
    if p.mov_avg_20d > p.mov_avg_50d
      p.uptrend
    end

    if p.mov_avg_20d < p.mov_avg_50d
      p.downtrend
      @end_point = @start_point = p
      if @current_trend
        @best_trends << @current_trend
        @current_trend = nil
      end
    end
  end

  def find_end_point(p)
    if p.px_high > start_point.px_high && p.px_high > end_point.px_high
      @end_point = p
      last_trend = @current_trend
      @current_trend = trend_line
      chart_trend(last_trend, @current_trend)
    end
  end

  def chart_trend(last, line)
    chart = Chart.new
    chart.labels(points.first(line.count).map { |p| p.date.to_s }, 4)
    %i{ mov_avg_20d mov_avg_50d px_high }.each do |plot|
      chart.data(plot, points.first(line.count).map(&plot))
    end
    chart.data('last', last)
    chart.data('start_end', line)
    #chart.data('up', points.map { |p| p.uptrend? ? p.mov_avg_20d : nil })
    chart.write("output/#{line.count}.png")
  end

  def trend_line
    [
      [nil] * (start_point.position-1),
      gradient,
      end_point.px_high
    ].flatten
  end

  def gradient
    times = (end_point.position - start_point.position)
    inc = (end_point.px_high - start_point.px_high) / times
    [].tap {|a| times.times {|t| a << start_point.px_high + (inc * t) }}
  end
end
