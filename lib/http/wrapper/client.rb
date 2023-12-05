# frozen_string_literal: true

require_relative "default_configuration"
require_relative "default_request"
require_relative "default_response"

module Http
  module Wrapper
    # The `Client` class provides a simple interface for making HTTP requests.
    class Client
      include ::Http::Wrapper::ApiExceptions
      include ::Http::Wrapper::HttpStatusCodes
      include ::Http::Wrapper::ErrorHandling
      include ::Http::Wrapper::ErrorHandling

      def initialize(base_url:, api_endpoint:, headers: {},
                     configuration: Http::Wrapper::DefaultConfiguration.new(base_url: base_url, api_endpoint: api_endpoint,
                                                                            headers: headers),
                     request: Http::Wrapper::DefaultRequest.new(configuration.connection),
                     response_class: Http::Wrapper::DefaultResponse)
        @config = configuration
        @request = request
        @response_class = response_class
      end

      def request(http_method:, endpoint:, params_type: :query, params: {})
        debugger
        response = @request.perform(http_method: http_method, endpoint: endpoint, params_type: params_type,
                                    params: params)
        handle_response(response)
      end

      private

      def handle_response(response)
        response_handler = @response_class.new(response)
        parsed_response = response_handler.handle

        return parsed_response if response_handler.response_successful?

        raise error_class(response), "Code: #{response.status}, response: #{response.body}"
      end
    end
  end
end
