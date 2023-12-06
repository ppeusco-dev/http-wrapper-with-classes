# frozen_string_literal: true

require "faraday"

module Http
  module Wrapper
    # Request class provides methods for handling HTTP requests in the HTTP wrapper.
    class DefaultRequest
      include ::Http::Wrapper::Interfaces::Request

      def initialize(connection)
        super()
        @connection = connection
      end

      def perform(http_method:, endpoint:, params_type: :query, params: {})
        request_methods = {
          query: -> { @connection.public_send(http_method, endpoint, params) },
          body: -> { perform_body(http_method, endpoint, params) }
        }

        request_method = request_methods[params_type] || (raise "Unknown params type: #{params_type}")
        request_method.call
      end

      private

      def perform_body(http_method, endpoint, params)
        @connection.send(http_method, endpoint) do |req|
          req.headers[:content_type] = "application/json"
          req.body = params
          req.adapter Faraday.default_adapter
        end
      end
    end
  end
end
