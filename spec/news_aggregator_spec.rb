# frozen_string_literal: true

require_relative "../lib/news_aggregator/version"

RSpec.describe NewsAggregator do
  it "has a version number" do
    expect(NewsAggregator::VERSION).not_to be nil
  end
end
