# frozen_string_literal: true

module NewsAggregator
  # News class represents the newsapi api
  class News
    require "net/http"
    require "json"

    BASE_URL = "https://newsapi.org/v2"

    def initialize(api_key:)
      @api_key = api_key
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
      status = request["status"]
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

    def _make_request(endpoint, **queries)
      params = eval(queries.inspect)
      uri = URI(_make_request_string(endpoint, params))
      req = Net::HTTP::Get.new(uri)
      req["X-Api-Key"] = @api_key
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
      json = JSON.parse(res.body)
      if res.code == '200'
        return json
      elsif res.code == '401'
        raise UnauthorizedException, json
      elsif res.code == '400'
        raise BadRequestException, json
      elsif res.code == '429' || res.code == '426'
        raise TooManyRequestsException, json
      elsif res.code == '500'
        raise ServerException, json
      end
    end

    def _make_request_string(endpoint, params)
      url = BASE_URL + endpoint + '?'
      params.each { |key, value| url += key.to_s + '=' + value.to_s + '&' }
      url = url[0..-2]
    end

    def _get_everything(endpoint, **args)
      request = _make_request(endpoint, **args)
      status = request['status']
      totalResults = request['totalResults']
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
