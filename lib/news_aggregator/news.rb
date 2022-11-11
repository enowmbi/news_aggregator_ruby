# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
module NewsAggregator
  # Locate articles and breaking news headlines from news sources and blogs across the web with newsapi.org
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
      sources.each do |source|
        data.push(create_new_source(source))
      end
      data
    end

    private

    def _make_request(endpoint, **query_params)
      response = connection.get(endpoint, query_params, { authorization: "bearer #{api_key}" })

      if response.status == "200"
        response.body
      else
        raise_exception(response)
      end
      response.body
    end

    def raise_exception(response)
      case response.status
      when "400" then raise BadRequestException, response.body
      when "401" then raise UnauthorizedException, response.body
      when "402" then raise PaymentRequiredException, response.body
      when "403" then raise ForbiddenException, response.body
      # when "426" then raise TooManyRequestsException, response.body
      when "429" then raise TooManyRequestsException, response.body
      when "500" then raise ServerException, response.body
      end
    end

    def _get_everything(endpoint, **args)
      request = _make_request(endpoint, **args)
      # status = request['status']
      # totalResults = request['totalResults']
      articles = request["articles"]
      data = []
      articles.each do |article|
        data.push(create_everything(article))
      end
      data
    end

    def create_new_source(source)
      Struct.new("Source", :id, :name, :description, :url, :category, :language, :country)
      Struct::Source.new(
        source["id"], source["name"], source["description"],
        source["url"], source["category"], source["language"],
        source["country"]
      )
    end

    def create_everything(article)
      Struct.new("Everything", :source, :author, :title, :description, :url, :url_to_image, :published_at, :content)
      Struct::Everything.new(
        article["source"], article["author"], article["title"],
        article["description"], article["content"], article["url"],
        article["urlToImage"], article["publishedAt"]
      )
    end
  end
end
