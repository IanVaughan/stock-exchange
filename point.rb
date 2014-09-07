class Point
  attr_reader :date, :px_open, :px_last, :px_high, :px_low, :rsi_14d, :mov_avg_20d, :mov_avg_50d
  attr_accessor :position

  @@count = 0

  def initialize data
    @date, @px_open, @px_last, @px_high, @px_low, @rsi_14d, @mov_avg_20d, @mov_avg_50d = data
    @position = @@count += 1
  end

  def trend dir
    @trend = dir
  end

  def uptrend?
    @trend == :up
  end

  def uptrend
    puts "Uptrend : #{self}"
    trend :up
  end

  def downtrend
    puts "Downtrend : #{self}"
    trend :down
  end

  def to_s
    "#{@position} - #{date}: #{mov_avg_20d}, #{mov_avg_50d}"
  end
end
