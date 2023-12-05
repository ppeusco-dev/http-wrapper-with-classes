# frozen_string_literal: true

module Http
  module Wrapper
    # Response class provides methods for handling HTTP responses in the HTTP wrapper.
    class DefaultResponse < Http::Wrapper::Interfaces::Configuration
      include ::Http::Wrapper::ErrorHandling
      include ::Http::Wrapper::HttpStatusCodes

      def initialize(response)
        super()
        @response = response
      end

      def handle
        parsed_response = Oj.load(@response.body)

        return parsed_response if response_successful?

        raise error_class, "Code: #{@response.status}, response: #{@response.body}"
      end

      def response_successful?
        status_symbol = STATUS_CODE_MAP[@response.status]
        SUCCESSFUL_STATUS.include?(status_symbol)
      end
    end
  end
end
