require './lib/analiser'
require './lib/calculate'
require './lib/csv_parser'
require './lib/point'
require './lib/sample'
require './lib/top_point_detection'
require './lib/trend'
require 'pry'

def load_test_input(file = 'test.csv')
  filename = "./spec/#{file}"
  Sample.reset_count

  [].tap do |points|
    CSV.foreach(filename) do |row|
      next if row.first == "Sample"
      data = {
        date: Date.today + points.count,
        px_high: row[1].to_i,
        px_low: row[2].to_i,
        mov_avg_50d: row[3].to_i,
        mov_avg_20d: row[4].to_i,
      }
      points << Sample.new(data)
    end
  end
end
