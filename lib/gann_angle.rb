class GannAngle
  attr_reader :start_point

  def initialize(points)
    @points = points
  end

  def run(days_before_startpoint)
    @finding_start_point ||= true
    points.each { |p| analise(p) }
  end

  private

  attr_reader :points

  def analise(p)
    find_start_point(p)
  end

  def find_start_point(p)
    if @finding_start_point && p.mov_avg_20d <= p.mov_avg_50d
      @start_point = p
      @finding_start_point = false
    end
  end
end
