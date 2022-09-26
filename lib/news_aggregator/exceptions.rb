# frozen_string_literal: true

module NewsAggregator
  # UnauthorizedException
  class UnauthorizedException < StandardError
    def initialize(json)
      super
      puts json["message"]
    end
  end

  # BadRequestException
  class BadRequestException < StandardError
    def initialize(json)
      super
      puts json["message"]
    end
  end

  # TooManyRequestException
  class TooManyRequestsException < StandardError
    def initialize(json)
      super
      puts json["message"]
    end
  end

  # ServerException
  class ServerException < StandardError
    def initialize(json)
      super
      puts json["message"]
    end
  end
end
