class Analiser
  def self.analysis(points)
    points.each do |p|
      # uptrend: 20 day moving average crossing above 50 day moving average
      # downtrend: 20 day crossing below the 50 day
      if p.mov_avg_20d > p.mov_avg_50d
        p.uptrend
        puts "Uptrend: #{p}"
      end

      if Point.uptrend? && p.mov_avg_20d < p.mov_avg_50d
        p.downtrend
        puts "Downtrend: #{p}"
      end
    end
  end
end
