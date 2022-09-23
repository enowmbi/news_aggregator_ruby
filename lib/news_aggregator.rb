# frozen_string_literal: true

require_relative "news_aggregator/version"

# Locate articles and breaking news headlines from news sources and blogs
# across the web with our newsapi.org
module NewsAggregator
  # Your code goes here...
  autoload(:News, "../news")
  autoload(:Error, "../error")
end
