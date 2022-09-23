# frozen_string_literal: true

# ApiKeyInvalid
class ApiKeyInvalidError < StandardError
  def initialize(json)
    puts json["message"]
  end
end

# ApiKeyMissing
class ApiKeyMissingError < StandardError
  def initialize(json)
    puts json["message"]
  end
end

# UnauthorizedException
class UnauthorizedException < StandardError
  def initialize(json)
    puts json["message"]
  end
end

# BadRequestException
class BadRequestException < StandardError
  def initialize(json)
    puts json["message"]
  end
end

# TooManyRequestException
class TooManyRequestsException < StandardError
  def initialize(json)
    puts json["message"]
  end
end

# ServerException
class ServerException < StandardError
  def initialize(json)
    puts json["message"]
  end
end
