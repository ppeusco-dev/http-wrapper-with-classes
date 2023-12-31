# frozen_string_literal: true

require "faraday"

require "http/wrapper/interfaces"
require "http/wrapper/version"
require "http/wrapper/http_status_codes"
require "http/wrapper/api_exceptions"
require "http/wrapper/error_handling"
require "http/wrapper/default_configuration"
require "http/wrapper/default_request"
require "http/wrapper/default_response"
require "http/wrapper/client"

module Http
  module Wrapper
    class Error < StandardError; end
    # Your code goes here...
  end
end
