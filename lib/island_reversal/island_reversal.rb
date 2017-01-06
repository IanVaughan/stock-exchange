class IslandReversal
  def render
    d = data_points(data['data'])
    {
      name: data['name'],
      data: d,
      marks: marks(d)
    }
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
    sell_points = []
    buy_points = []

    points.map.with_index do |p, i|
      if p[2] < points[i-1][3]
        sell_points << [p[0], p[2]]
      elsif p[3] > points[i-1][2]
        buy_points << [p[0], p[2]]
      end
    end

    {
      sell: sell_points,
      buy: buy_points
    }
  end
end
