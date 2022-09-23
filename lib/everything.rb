# frozen_string_literal: true

# /v2/everything
class Everything
  attr_accessor :id, :name, :author, :title, :description, :url, :url_to_image, :published_at, :content

  def initialize(source, author, title, description, url, url_to_image, published_at, content)
    @id = source["id"]
    @name = source["name"]
    @author = author
    @title = title
    @description = description
    @url = url
    @url_to_image = url_to_image
    @published_at = published_at
    @content = content
  end
end
