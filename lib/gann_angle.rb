class GannAngle
  attr_reader :days_before_startpoint, :a_b_window
  attr_reader :start_point, :end_point
  attr_reader :point_a, :point_b
  attr_reader :alpha, :beta, :gamma

  def initialize(points)
    @points = points
  end

  def run(days_before_startpoint, a_b_window)
    @days_before_startpoint = days_before_startpoint
    @a_b_window = a_b_window

    reset

    points.each do |p|
      unless find_start_point(p)
        @point_a = @points[start_point.position - days_before_startpoint]

        unless find_end_point(p)
          # 3. Lowest low point between p1 and p2, mark as B
          @point_b = lowest(@points[start_point.position..end_point.position])

          # 4. Test that B - A > 90 days, ignore if not
          if point_b.position - point_a.position < a_b_window
            reset
          else
            # 5. Calculate price difference between A and B
            @alpha, @beta, @gamma = calc_price_diff
          end
        end
      end
    end
  end

  private

  attr_reader :points

  def reset
    @finding_start_point = true
    @finding_end_point = true
  end

  def find_start_point(p)
    if @finding_start_point && p.mov_avg_20d <= p.mov_avg_50d
      @start_point = p
      @finding_start_point = false
    end
    @finding_start_point
  end

  def find_end_point(p)
    if @finding_end_point && p.mov_avg_20d > p.mov_avg_50d
      @end_point = p
      @finding_end_point = false
    end
    @finding_end_point
  end

  def lowest(points)
    points.sort_by!(&:px_low).first
  end

  def calc_price_diff
    # 5. Calculate price difference between A and B, call this “y”
    y = point_a.px_high.to_f - point_b.px_low.to_f
    # 6. Calculate number of trading days between A and B, call this “x”
    x = point_b.position.to_f - point_a.position.to_f

    alpha = y / x
    beta = (y * 0.618) / x
    gamma = (y * 0.382) / x

    [alpha, beta, gamma]
  end
end
