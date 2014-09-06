class Analiser
  attr_reader :points, :start_point, :end_point

  def self.analysis(points)
    self.new(points).run
  end

  def initialize(points)
    @points = points
  end

  def run
    points.each_with_index { |p, i| analise(p, i) }
  end

  def analise(p, i)
    # start point : 20ma crosses 50ma
    # also moves start point
    find_start_point(p)
    find_end_point(p, i) if start_point
  end

  def find_start_point(p)
    if p.mov_avg_20d > p.mov_avg_50d
      p.uptrend
      @start_point = p
    end

    p.downtrend if p.mov_avg_20d < p.mov_avg_50d
  end

  def find_end_point(p, i)
    if p.px_high > start_point.px_high
      @end_point = p
      dump_data(i)
    end
  end

  def dump_data(i)
    return
    chart = Chart.new(type: :line, size: 10000)
    %i{ mov_avg_20d mov_avg_50d px_high }.each do |p|
      chart.data(p, points[0..i].map(&p))
    end
    chart.data('start_end', [start_point.px_high, end_point.px_high])
    chart.write("#{i}-bob.png")
  end
end
