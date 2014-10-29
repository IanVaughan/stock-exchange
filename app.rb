require 'sinatra'
require './lib/csv_parser'
require './lib/sample'
require 'pry'

get '/' do
  data = CsvParser.parse('data/sx5e_index.csv')
  samples = data
  erb :index, locals: { samples: samples.map(&:to_chart) }
end
