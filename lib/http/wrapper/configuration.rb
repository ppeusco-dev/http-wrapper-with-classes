# frozen_string_literal: true

require "faraday" # Asegúrate de requerir la gema Faraday

module Http
  module Wrapper
    # Configuration class provides methods for configuring Faraday connections.
    class Configuration
      def initialize(base_url:, api_endpoint:, headers: {}, faraday_options: {})
        @base_url = base_url
        @api_endpoint = api_endpoint
        @headers = headers
        @faraday_options = faraday_options
      end

      def connection
        @connection ||= build_faraday_connection.tap do |configured_conn|
          configure_faraday_headers(configured_conn)
        end
      end

      private

      def build_faraday_connection
        url = build_url
        url_with_scheme = add_scheme_to_url(url)

        Faraday.new(url_with_scheme, @faraday_options) do |conn|
          conn.adapter Faraday.default_adapter
        end
      end

      def configure_faraday_headers(conn)
        headers = build_headers

        headers.each do |key, value|
          conn.headers[key.to_s] = value.to_s
        end
      end

      def build_headers
        @headers.each_with_object({}) { |(key, value), hash| hash[key.to_s] = value.to_s }
      end

      def build_url
        full_url = "#{@base_url.to_s.chomp("/")}/#{@api_endpoint.to_s.sub(%r{^/}, "")}"
        URI.parse(full_url).tap do |uri|
          uri.scheme = "http" unless uri.scheme =~ /^https?$/
        end.to_s
      end

      def add_scheme_to_url(url)
        uri = URI.parse(url)
        uri.scheme = "https" if uri.scheme.nil? || uri.scheme.empty?
        uri.to_s
      end
    end
  end
end
