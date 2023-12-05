# frozen_string_literal: true

require_relative "configuration"
require_relative "request"
require_relative "response"

module Http
  module Wrapper
    # The `Client` class provides a simple interface for making HTTP requests.
    class Client
      include ::Http::Wrapper::ApiExceptions
      include ::Http::Wrapper::HttpStatusCodes
      include ::Http::Wrapper::ErrorHandling
      include ::Http::Wrapper::ErrorHandling

      # Initializes a new instance of the `Client` class.
      #
      # @param base_url [String] The base URL of the API.
      # @param api_endpoint [String] The API endpoint to be appended to the base URL.
      # @param headers [Hash] Additional headers to include in the HTTP requests.
      def initialize(base_url:, api_endpoint:, headers: {})
        @config = Configuration.new(base_url: base_url, api_endpoint: api_endpoint, headers: headers)
      end

      # Sends an HTTP request to the specified endpoint.
      #
      # @param http_method [Symbol] The HTTP method for the request (:get, :post, :put, etc.).
      # @param endpoint [String] The API endpoint to send the request to.
      # @param params_type [Symbol] The type of parameters (:query or :body).
      # @param params [Hash] The parameters to include in the request.
      # @return [Object] The parsed response from the server.
      def request(http_method:, endpoint:, params_type: :query, params: {})
        connection = @config.connection
        request = Request.new(connection)
        response = request.perform(http_method: http_method, endpoint: endpoint, params_type: params_type,
                                   params: params)
        handle_response(response)
      end

      private

      def handle_response(response)
        response_handler = Response.new(response)
        parsed_response = response_handler.handle

        return parsed_response if response_handler.response_successful?

        raise error_class(response), "Code: #{response.status}, response: #{response.body}"
      end
    end
  end
end
