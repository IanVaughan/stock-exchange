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
    all_points = session[:points]

    start_point = (params['start_point'] || 0).to_i
    end_point = (params['end_point'] || all_points.size).to_i
    if end_point <= 0 || end_point >= all_points.size
      end_point = all_points.size
    end
    points = all_points[start_point..end_point]
    Sample.offset = start_point

    ww = (params['window_width'] || 40).to_i
    gua = (params['give_up_after'] || 50).to_i
    cc = 3
    ohlc_selected = params['ohlc_select'] || false
    seperate_lines = params['others_select'] || true
    days_previous = (params['days_previous'] || 60).to_i
    min_a_b_window_width = (params['min_a_b_window_width'] || 90).to_i

    erb :graph, locals: {
      window_width: ww,
      give_up_after: gua,
      days_previous: days_previous,
      start_point: start_point,
      end_point: end_point,
      min_a_b_window_width: min_a_b_window_width,
      seperate_lines: seperate_lines,
      filename: File.basename(filename),

      high: points.map {|p| [p.chart_date, p.px_high] },
      open: points.map {|p| [p.chart_date, p.px_open] },
      close: points.map {|p| [p.chart_date, p.px_last] },
      low: points.map {|p| [p.chart_date, p.px_low] },
      avg20d: points.map {|p| [p.chart_date, p.mov_avg_20d] },
      avg50d: points.map {|p| [p.chart_date, p.mov_avg_50d] },
      data_labels: data_labels(points, ww, gua, cc),
      ohlc: ohlc_selected ? points.map(&:to_chart) : nil,
      angles: gann_data(points, days_previous, min_a_b_window_width)
    }
  end
end

def gann_data(points, days_previous, window_width)
  ga = GannAngle.new(points)
  ga.run(days_previous, window_width)

  series = []

  ga.angles.each do |start_point, data_set|
    data = {}

    GannAngle::ANGLES.keys.each do |name|
      data[name.to_s] = Calculate.project(
        start_point.to_point,
        data_set[:x],
        data_set[name],
        points)
    end

    series << data
  end

  series
end

def filename
  './data/sx5e_index.csv'
end

def load_data
  session[:points] = CsvParser.parse(filename)
end

def data_labels(points, window_width, give_up_after, collection_count)
  tpd = TopPointDetection.new(points)
  tpd.run(window_width, give_up_after, collection_count)

  tpd.collections.each_with_index.flat_map do |collection, ci|
    collection.each_with_index.map do |sample, si|
      {
        x: sample.chart_date,
        title: "#{ci}:#{si}"
      }
    end
  end
end
