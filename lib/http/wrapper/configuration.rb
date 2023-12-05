# frozen_string_literal: true

module Http
  module Wrapper
    # Configuration class provides methods for configuring Faraday connections.
    class Configuration
      def initialize(base_url:, api_endpoint:, headers: {})
        @base_url = base_url
        @api_endpoint = api_endpoint
        @headers = headers
      end

      def connection(faraday_options: {})
        connection = ConnectionBuilder.build_faraday_connection(build_url, faraday_options)
        HeadersConfigurator.configure_faraday_headers(connection, @headers)
        connection
      end

      private

      def build_url
        full_url = "#{@base_url.to_s.chomp("/")}/#{@api_endpoint.to_s.sub(%r{^/}, "")}"
        URI.parse(full_url).tap do |uri|
          uri.scheme = "http" unless uri.scheme =~ /^https?$/
        end.to_s
      end
    end

    # ConnectionBuilder class for building Faraday connections
    class ConnectionBuilder
      def self.build_faraday_connection(url, options)
        Faraday.new(url, options) do |conn|
          conn.adapter Faraday.default_adapter
        end
      end
    end

    # HeadersConfigurator class for configuring Faraday headers
    class HeadersConfigurator
      def self.configure_faraday_headers(connection, headers)
        headers.each do |key, value|
          connection.headers[key.to_s] = value.to_s
        end
      end
    end
  end
end
