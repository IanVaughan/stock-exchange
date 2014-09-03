class Point
  attr_accessor :date, :px_open, :px_last, :px_high, :px_low, :rsi_14d, :mov_avg_20d, :mov_avg_50d

  def initialize raw_row
    raw_date, *raw_numbers = raw_row
    @date = extract_date(raw_date)
    @px_open, @px_last, @px_high, @px_low, @rsi_14d, @mov_avg_20d, @mov_avg_50d = raw_numbers.map(&:to_f)
  end

  def extract_date raw_date
    month, day, year = raw_date.split('/').map(&:to_i)
    Date.new(year, month, day)
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
