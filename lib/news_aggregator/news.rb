# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
module NewsAggregator
  # News class represents the newsapi api
  class News
    BASE_URL = "https://newsapi.org/v2"
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

    def top_headlines(**args)
      endpoint = "top-headlines"
      _get_everything(endpoint, **args)
    end

    def everything(**args)
      endpoint = "everything"
      _get_everything(endpoint, **args)
    end

    def sources(**args)
      endpoint = "sources"
      request = _make_request(endpoint, **args)
      # status = request["status"]
      sources = request["sources"]
      data = []
      sources.each do |v|
        data.push(
          Source.new(
            v["id"], v["name"], v["description"],
            v["url"], v["category"], v["language"],
            v["country"]
          )
        )
      end
      data
    end

    private

    def _make_request(endpoint, **query_params)
      response = connection.get(endpoint, query_params, { authorization: "bearer #{api_key}" })
      case response.status
      when "200"
        return response.body
      when "401"
        raise UnauthorizedException, response.body
      when "400"
        raise BadRequestException, response.body
      when "429" || "426"
        raise TooManyRequestsException, response.body
      when "500"
        raise ServerException, response.body
      end
      response.body
    end

    def _get_everything(endpoint, **args)
      request = _make_request(endpoint, **args)
      # status = request['status']
      # totalResults = request['totalResults']
      articles = request["articles"]
      data = []
      articles.each do |a|
        data.push(
          Everything.new(
            a["source"], a["author"], a["title"],
            a["description"], a["content"], a["url"],
            a["urlToImage"], a["publishedAt"]
          )
        )
      end
      data
    end
  end
end
