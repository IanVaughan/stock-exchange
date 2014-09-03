class Analiser
  def self.analysis(points)
    action = self.new(points)
    action.trends
    action.vibrations
  end

  def initialize(points)
    @points = points
  end

  attr_reader :points

  def trends
    points.each do |p|
      # uptrend: 20 day moving average crossing above 50 day moving average
      # downtrend: 20 day crossing below the 50 day
      if p.mov_avg_20d > p.mov_avg_50d
        p.uptrend
        puts "Uptrend: #{p}"
      end

      if p.mov_avg_20d < p.mov_avg_50d
        p.downtrend
        puts "Downtrend: #{p}"
      end
    end
  end

  # Identify the vibration / frequency of each trend
  # by measuring the price vs time gradient across the high prices or low prices.
  # i.e. in an uptrend the gradient should be measured across the two highest highs
  # that creates the lowest gradient trend / vibration
  def vibrations
    trends = points.chunk {|p| p.uptrend?}.to_a
    trends.first.last.sort_by! {|p| p.px_high}
    puts trends.first.last[-2..-1]
  end
end
