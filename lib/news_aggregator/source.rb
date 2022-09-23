# frozen_string_literal: true

module NewsAggregator
  # source class
  class Source
    attr_accessor :id, :name, :description, :url, :category, :language, :country

    def initialize(id, name, description, url, category, language, country)
      @id = id
      @name = name
      @description = description
      @url = url
      @category = category
      @language = language
      @country = country
    end
  end
end
