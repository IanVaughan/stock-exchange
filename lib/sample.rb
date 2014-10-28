class Sample
  attr_reader :date, :px_open, :px_last, :px_high, :px_low, :rsi_14d, :mov_avg_20d, :mov_avg_50d
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

  def trend dir
    @trend = dir
  end

  def uptrend?
    @trend == :up
  end

  def downtrend?
    @trend == :up
  end

  def uptrend
    trend :up
  end

  def downtrend
    trend :down
  end

  def latch
    @latch = true
  end

  def latched?
    @latch
  end

  def to_s
    "#{@position} - #{date}: 20d:#{mov_avg_20d}, 50d:#{mov_avg_50d}, px_high:#{px_high}"
  end

  def to_h
    {
      position: @position,
    }
  end

  def -(other)
    Point.new(
      self.position - other.position,
      self.px_high - other.px_high
    )
  end

  def <(other)
    self.px_high < other.px_high
  end

  def >(other)
    self.px_high > other.px_high
  end

  def >=(other)
    self.px_high >= other.px_high
  end
end
