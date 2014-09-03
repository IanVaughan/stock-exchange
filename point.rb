class Point
  attr_accessor :date, :px_open, :px_last, :px_high, :px_low, :rsi_14d, :mov_avg_20d, :mov_avg_50d

  def initialize row
    @date, @px_open, @px_last, @px_high, @px_low, @rsi_14d, @mov_avg_20d, @mov_avg_50d = row
    @@uptrend = false
  end

  def trend dir
    @trend = dir
    @@uptrend = dir == :up
  end

  def uptrend?
    @trend == :up
  end

  def uptrend
    trend :up
  end

  def downtrend
    trend :down
  end

  def self.uptrend?
    @@uptrend
  end

  def to_s
    "#{date}: #{px_high} #{mov_avg_20d}, #{mov_avg_50d}"
  end
end
