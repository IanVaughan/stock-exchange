class Sample
  attr_reader :date, :px_open, :px_last, :px_high, :px_low
  attr_reader :rsi_14d, :mov_avg_20d, :mov_avg_50d
  attr_accessor :position

  @@count = 0

  def initialize data
    @position = @@count += 1
    if data.is_a? Array
      @date, @px_open, @px_last, @px_high, @px_low, @rsi_14d, @mov_avg_20d, @mov_avg_50d = data
    elsif data.is_a? Hash
      data.each { |k,v| self.instance_variable_set("@#{k}", v) }
    end
  end

  def self.reset_count
    @@count = 0
  end

  def to_chart
    [
      chart_date,
      px_high,
      px_low
    ]
  end

  def chart_date
    date.to_time.to_i * 1000
  end

  def -(other)
    Point.new(
      self.position - other.position,
      self.px_high - other.px_high
    )
  end
end
