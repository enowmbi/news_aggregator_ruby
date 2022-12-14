# frozen_string_literal: true

require_relative "lib/news_aggregator/version"

Gem::Specification.new do |spec|
  spec.name = "news_aggregator"
  spec.version = NewsAggregator::VERSION
  spec.authors = ["Enow Mbi"]
  spec.email = ["benowmbi@yahoo.com"]

  spec.summary = "Newsapi SDK for ruby "
  spec.description = "Get top news headlines from newsapi.org using Ruby"
  spec.homepage = "https://github.com/enowmbi/news_aggregator_ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency "faraday", "~>1.10.2"
  spec.add_dependency "faraday_middleware", "~>1.2"
  spec.add_development_dependency "pry"
end
