require 'sinatra'
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
    points = CsvParser.parse(filename)
    session[:points] = points
    redirect '/'
  end

  get '/graph' do
    points = session[:points]

    if points.nil?
      session[:flash] = 'no data!'
      return
    end

    ww = (params['window_width'] || 4).to_i
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

def top_points(points, window_width, give_up_after)
  tpd = TopPointDetection.new(points)
  tpd.run(window_width, give_up_after)
  tpd.high_points.map(&:to_chart)
end
