class Point
  attr_accessor :date, :px_open, :px_last, :px_high, :px_low, :rsi_14d, :mov_avg_20d, :mov_avg_50d

  def initialize data
    @date, @px_open, @px_last, @px_high, @px_low, @rsi_14d, @mov_avg_20d, @mov_avg_50d = data
  end

  def trend dir
    @trend = dir
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

  def to_s
    "#{date}: #{mov_avg_20d}, #{mov_avg_50d}"
  end
end
