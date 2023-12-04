# frozen_string_literal: true

module Http
  module Wrapper
    # Response class provides methods for handling HTTP responses in the HTTP wrapper.
    class Response
      include ErrorHandling
      include HttpStatusCodes

      def initialize(response)
        @response = response
      end

      def handle
        parsed_response = Oj.load(@response.body)

        return parsed_response if response_successful?

        raise error_class, "Code: #{@response.status}, response: #{@response.body}"
      end

      private

      def response_successful?
        SUCCESSFUL_STATUS.include?(@response.status)
      end
    end
  end
end
