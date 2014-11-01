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

    erb :graph, locals: {
      window_width: ww,
      give_up_after: gua,
      samples: points.map(&:to_chart),
      collections: collections(points, ww, gua, cc)
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

  collections.to_json
end
