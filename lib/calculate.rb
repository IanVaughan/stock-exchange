class Calculate
  def self.diff(p1, p2)
    angle(p2) - angle(p1)
  end

  def self.angle(a, b = nil)
    if b.nil?
      s = a
      a = s.first
      b = s.last
    end
    return 0 if b.zero?
    Math::atan(b.to_f / a.to_f) * (180.0/ Math::PI)
  end
end
