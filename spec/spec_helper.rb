require './lib/point'
require './lib/csv_parser'
require './lib/analiser'
require './lib/chart'
require 'pry'

def load_test_input(filename = './spec/test.csv')
  Point.reset_count

  [].tap do |points|
    CSV.foreach(filename) do |row|
      next if row.first == "Point"
      data = {
        date: Date.today+points.count,
        mov_avg_20d: row[1].to_i,
        mov_avg_50d: row[2].to_i,
        px_high: row[3].to_i
      }
      points << Point.new(data)
    end
  end
end
