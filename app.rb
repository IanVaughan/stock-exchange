require 'sinatra'
require './lib/shares'

get '/' do
  filename = './data/sx5e_index.csv'
  points = CsvParser.parse(filename)
  # points = points[0..200]
  top_points = TopPointDetection.new(points)
  top_points.run(4)
  erb :index, locals: {
    samples: points.map(&:to_chart),
    top_points: top_points.high_points.map(&:to_chart)
  }
end
