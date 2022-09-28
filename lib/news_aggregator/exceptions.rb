# frozen_string_literal: true

module NewsAggregator
  # UnauthorizedException
  class UnauthorizedException < StandardError
    def initialize(json)
      puts json["message"] || super
    end
  end

  # BadRequestException
  class BadRequestException < StandardError
    def initialize(json)
      puts json["message"] || super
    end
  end

  # TooManyRequestException
  class TooManyRequestsException < StandardError
    def initialize(json)
      puts json["message"] || super
    end
  end

  # ServerException
  class ServerException < StandardError
    def initialize(json)
      puts json["message"] || super
    end
  end
end
