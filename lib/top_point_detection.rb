class TopPointDetection
  attr_reader :high_points

  def initialize(points)
    @points = points
  end

  def run(window_width)
    @high_points = []
    @window_width = window_width
    points.each { |p| analise(p) }
  end

  private
  attr_reader :points, :window_width, :high_point

  def analise(p)
    @high_point ||= p

    # Find next higher point
    if p.px_high > @high_point.px_high
      @high_point = p
      @new_high = true
    end

    # Save found higher point
    if @new_high && (p.position - @high_point.position) >= window_width
      @high_points << @high_point
      @new_high = false

      if @high_points.count % 3 == 0
        @high_point = nil
      end
    end

    # Give up finding higher point after a while
    # if (p.position - @high_point.position) >= 50 #give_up_after
    #   @high_point = nil
    # end
  end
end
