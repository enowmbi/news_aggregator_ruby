# frozen_string_literal: true

require "faraday"
require "faraday_middleware"

# NewsAggregator
module NewsAggregator
  # Locate articles and breaking news headlines from news sources and blogs across the web with newsapi.org
  class News
    BASE_URL = "https://newsapi.org/v2"

    END_POINTS = %w[top-headlines everything sources].freeze

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end

    def make_request(endpoint, **query_params)
      response = connection.get(endpoint, query_params, { authorization: "bearer #{api_key}" })

      return response.body if response.status == 200

      raise_exception(response)
    end

    END_POINTS.each do |end_point|
      define_method(end_point.tr("/-", "_").to_sym) do |**args|
        make_request(end_point, **args)
      end
    end
  end

  private

  def raise_exception(response)
    case response.status
    when "400" then raise BadRequestException, response.body
    when "401" then raise UnauthorizedException, response.body
    when "402" then raise PaymentRequiredException, response.body
    when "403" then raise ForbiddenException, response.body
    when "429" then raise TooManyRequestsException, response.body
    when "500" then raise ServerException, response.body
    end
  end
end
