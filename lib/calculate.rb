class Calculate
  def self.diff(p1, p2)
    angle(p2) - angle(p1)
  end

  def self.angle(a, b = nil)
    if b.nil?
      s = a
      a = s.x
      b = s.y
    end
    return 0 if b.zero?
    Math::atan(b.to_f / a.to_f) * (180.0/ Math::PI)
  end

  def self.to_rad(deg)
    deg * Math::PI / 180.0
  end

  def self.project(start_point, steps, angle_deg)
    # Tan(q) = Opposite / Adjacent
    opposite = Math::tan(to_rad(angle_deg)) * steps

    end_point = Point.new(start_point.x + steps, start_point.y + opposite)
    # diff for each step = end(high) - start(low) / steps
    diff = (end_point.y - start_point.y) / steps

    [].tap do |result|
      steps.times do |step|
        result << Point.new(start_point.x + step, start_point.y + (diff * step))
      end
    end
  end
end
