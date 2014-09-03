#!/usr/bin/env ruby

require './point'
require './csv_parser'
require './analiser'
require './chart'
require 'pry'

filename = 'sx5e_index.csv'
points = CsvParser.parse(filename)
Analiser.analysis(points)

points = points[0..1000]

#Chart.new.line.labels(['a','b','c']).data('Ian',[1,5,20]).create('bob.png')
puts "Creating chart..."
chart = Chart.new.line(size: 5000)
chart.labels(points.map { |p| p.date.to_s })


  # px_open
  # px_last
  # px_high
  # px_low
  # rsi_14d
%i{
  mov_avg_20d
  mov_avg_50d
}.each do |p|
  chart.data(p, points.map(&p))
end
chart.data('up', points.map { |p| p.uptrend? ? p.mov_avg_20d : 0 })

chart.create('bob.png')
