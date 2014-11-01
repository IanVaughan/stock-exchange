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
    tops = top_points(points, ww, gua)

    erb :graph, locals: {
      window_width: ww,
      give_up_after: gua,
      samples: points.map(&:to_chart),
      tops: tops
    }
  end
end

def filename
  './data/sx5e_index.csv'
end

def load_data
  session[:points] = CsvParser.parse(filename)
end

def top_points(points, window_width, give_up_after)
  tpd = TopPointDetection.new(points)
  tpd.run(window_width, give_up_after)
  points = tpd.high_points.map(&:to_chart)
  points.map do |t|
    { x: t[0], title: 'A' }
  end.to_json
end
