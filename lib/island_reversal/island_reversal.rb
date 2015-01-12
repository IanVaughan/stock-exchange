require 'httparty'

class IslandReversal
  BASE_PATH = "https://www.quandl.com/api/v1/datasets/"
  DATA_SET = "YAHOO/INDEX_IBEX.json?"
  START_DATE = "trim_start=2014-03-31&"
  END_DATE = "trim_end=2015-04-19&"
  AUTH = "auth_token=XJbxD7B_srwgWv_BvSub"
  DATA_PATH = BASE_PATH + DATA_SET + START_DATE + END_DATE + AUTH

  def render
    {
      name: data['name'],
      data: data_points(data['data']),
    }
  end

  def data
    JSON.parse(response.body)
  end

  def response
    @response ||= HTTParty.get(DATA_PATH)
  end

  def data_points(points)
    points.map do |p|
      [
        convert_to_date(p[0]).to_time.to_i * 1000,
        p[1..4]
      ].flatten
    end.sort
  end

  def convert_to_date(p)
    Date.strptime(p, "%Y-%m-%d")
  end
end
