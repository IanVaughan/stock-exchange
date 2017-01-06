require 'httparty'

class QuandlApi
  include HTTParty
  format :json:q!
  base_uri 'whoismyrepresentative.com'

  BASE_PATH = "https://www.quandl.com/api/v1/datasets/"
  DATA_SET = "YAHOO/INDEX_IBEX.json?"
  START_DATE = "trim_start=2014-03-31&"
  END_DATE = "trim_end=2015-04-19&"
  AUTH = "auth_token=XJbxD7B_srwgWv_BvSub"
  DATA_PATH = BASE_PATH + DATA_SET + START_DATE + END_DATE + AUTH

  # def data
  #   JSON.parse(response.body)
  # end

  # def response
  #   @response ||= HTTParty.get(DATA_PATH)
  # end

  def self.data
    get(DATA_PATH)
  end
end
