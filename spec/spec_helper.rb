require './lib/analiser'
require './lib/calculate'
require './lib/csv_parser'
require './lib/point'
require './lib/sample'
require './lib/top_point_detection.rb'
require './lib/trend'
require 'pry'

def load_test_input(filename = './spec/test.csv')
  Sample.reset_count

  [].tap do |points|
    CSV.foreach(filename) do |row|
      next if row.first == "Sample"
      data = {
        date: Date.today+points.count,
        px_high: row[1].to_i
      }
      points << Sample.new(data)
    end
  end
end
