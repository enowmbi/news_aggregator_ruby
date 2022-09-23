# frozen_string_literal: true

# Loads dependencies using lazy loading
module NewsAggregator
  autoload(:News, "news_aggregator/news")
  autoload(:UnauthorizedException, "news_aggregator/exceptions")
  autoload(:BadRequestException, "news_aggregator/exceptions")
  autoload(:TooManyRequestsException, "news_aggregator/exceptions")
  autoload(:ServerException, "news_aggregator/exceptions")
  autoload(:Source, "news_aggregator/source")
  autoload(:Everything, "news_aggregator/everything")
end
