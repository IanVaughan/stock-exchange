require 'sinatra'
require 'lazy_high_charts'
require './lib/csv_parser'
require './lib/sample'
require 'pry'
include LazyHighCharts::LayoutHelper

get '/' do
  highchart_example
  erb :index
end

def highchart_example
  data = CsvParser.parse('data/sx5e_index.csv')
  samples = data.first(100)
  @chart = LazyHighCharts::HighChart.new('graph') do |f|
    f.title({ text: "Foo chart"})
    f.options[:xAxis][:categories] = (0..samples.size-1).map { |i| i % 10 == 0 ? samples[i].date.to_s : '' }
    f.series(type: 'line', name: 'px high', data: samples.map(&:px_high))
  end
end
