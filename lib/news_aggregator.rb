# frozen_string_literal: true

# Locate articles and breaking news headlines from news sources and blogs
# across the web with our newsapi.org
module NewsAggregator
  autoload(:News, "news_aggregator/news")
  autoload(:UnauthorizedException, "news_aggregator/exceptions")
  autoload(:BadRequestException, "news_aggregator/exceptions")
  autoload(:TooManyRequestsException, "news_aggregator/exceptions")
  autoload(:ServerException, "news_aggregator/exceptions")
  autoload(:Source, "news_aggregator/source")
  autoload(:Everything, "news_aggregator/everything")
end
