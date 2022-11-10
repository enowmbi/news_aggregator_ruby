[![Gem Version](https://badge.fury.io/rb/news_aggregator.svg)](https://badge.fury.io/rb/news_aggregator)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rubystyle.guide)
[![Ruby on Rails CI](https://github.com/enowmbi/news_aggregator_ruby/actions/workflows/ruby.yml/badge.svg)](https://github.com/enowmbi/news_aggregator_ruby/actions/workflows/ruby.yml)

# NewsAggregator
Ruby client library for accessing News API.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add news_aggregator

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install news_aggregator

## Usage

### Initilisation

```ruby
require 'news_aggregator'

n = NewsAggregator::News.new("api_key")
```

### Sources

```ruby
n.sources(country: 'us', language: 'en')
```

### Everything

```ruby
n.everything(q: "apple", from: "2018-01-05&to=2018-01-05", sortBy: "popularity")
```

### Top Headlines

```ruby
n.top_headlines(sources: "bbc-news")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/enowmbi/news_aggregator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/news_aggregator/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NewsAggregator project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/news_aggregator/blob/master/CODE_OF_CONDUCT.md).
