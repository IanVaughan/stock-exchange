require 'sinatra'
require 'json'
require './lib/shares'

use Rack::Session::Pool

class App < Sinatra::Application

  configure :production, :development do
    enable :logging
  end

  get '/' do
    erb :index
  end

  get '/load' do
    load_data
    redirect '/'
  end

  get '/graph' do
    load_data if session[:points].nil?
    points = session[:points]

    ww = (params['window_width'] || 40).to_i
    gua = (params['give_up_after'] || 50).to_i
    cc = 3
    ohlc_selected = params['ohlc_select'] || false
    seperate_lines = params['others_select'] || false

    erb :graph, locals: {
      window_width: ww,
      give_up_after: gua,
      high: points.map {|p| [p.chart_date, p.px_high] },
      open: points.map {|p| [p.chart_date, p.px_open] },
      close: points.map {|p| [p.chart_date, p.px_last] },
      low: points.map {|p| [p.chart_date, p.px_low] },
      avg20d: points.map {|p| [p.chart_date, p.mov_avg_20d] },
      avg50d: points.map {|p| [p.chart_date, p.mov_avg_50d] },
      collections: collections(points, ww, gua, cc),
      ohlc: ohlc_selected ? points.map(&:to_chart) : nil,
      seperate_lines: seperate_lines
    }
  end
end

def filename
  './data/sx5e_index.csv'
end

def load_data
  session[:points] = CsvParser.parse(filename)
end

def collections(points, window_width, give_up_after, collection_count)
  tpd = TopPointDetection.new(points)
  tpd.run(window_width, give_up_after, collection_count)

  collections = tpd.collections.each_with_index.flat_map do |collection, ci|
    collection.each_with_index.map do |sample, si|
      {
        x: sample.chart_date,
        title: "#{ci}:#{si}"
      }
    end
  end
end
