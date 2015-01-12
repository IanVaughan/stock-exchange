require 'httparty'

class IslandReversal
  BASE_PATH = "https://www.quandl.com/api/v1/datasets/"
  DATA_SET = "YAHOO/INDEX_IBEX.json?"
  START_DATE = "trim_start=2014-03-31&"
  END_DATE = "trim_end=2015-04-19&"
  AUTH = "auth_token=XJbxD7B_srwgWv_BvSub"
  DATA_PATH = BASE_PATH + DATA_SET + START_DATE + END_DATE + AUTH

  def render
    d = data_points(data['data'])
    {
      name: data['name'],
      data: d,
      marks: marks(d)
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
        convert_date(p[0]),
        p[1..4]
      ].flatten
    end.sort
  end

  def convert_date(p)
    Date.strptime(p, "%Y-%m-%d").to_time.to_i * 1000
  end

  # sell signals
  # 10 > 20
  # 10 minus 5 days) > 20 (5 days ago)
  # current high < yesterdays low

  def marks(points)
    keep = []
    points.map.with_index do |p, i|
      if p[2] < points[i-1][3]
        keep << [p[0], p[2]]
      end
    end
    keep
  end
end
