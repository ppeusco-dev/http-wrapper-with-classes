# frozen_string_literal: true

module Http
  module Wrapper
    # ErrorHandling module provides methods for handling errors in the HTTP wrapper.
    module ErrorHandling
      include ::Http::Wrapper::HttpStatusCodes
      include ::Http::Wrapper::ApiExceptions

      private

      ERROR_MAPPING = {
        OK => nil,
        CREATED => nil,
        ACCEPTED => nil,
        NO_CONTENT => nil,
        MOVED_PERMANENTLY => nil,
        FOUND => nil,
        NOT_MODIFIED => nil,
        TEMPORARY_REDIRECT => nil,
        PERMANENT_REDIRECT => nil,
        BAD_REQUEST => ApiExceptions.const_get("BadRequestError").new,
        UNAUTHORIZED => ApiExceptions.const_get("UnauthorizedError").new,
        FORBIDDEN => ->(response) { forbidden_error(response) },
        NOT_FOUND => ApiExceptions.const_get("NotFoundError").new,
        UNPROCESSABLE_ENTITY => ApiExceptions.const_get("UnprocessableEntityError").new,
        TOO_MANY_REQUESTS => ApiExceptions.const_get("ApiRequestsQuotaReachedError").new,
        INTERNAL_SERVER_ERROR => ApiExceptions.const_get("InternalServerError").new,
        BAD_GATEWAY => ApiExceptions.const_get("BadGatewayError").new,
        SERVICE_UNAVAILABLE => ApiExceptions.const_get("ServiceUnavailableError").new,
        GATEWAY_TIMEOUT => ApiExceptions.const_get("GatewayTimeoutError").new,
        DEFAULT => ApiExceptions.const_get("ApiError").new
      }.freeze

      def error_class
        status_symbol = STATUS_CODE_MAP[@response.status] || @response.status.to_s.to_sym
        ERROR_MAPPING[status_symbol] || UnknownStatusError.new(status_symbol)
      end

      def api_requests_quota_reached?
        @response.body.match?(API_REQUESTS_QUOTA_REACHED_MESSAGE)
      end

      def forbidden_error(response)
        return ApiExceptions.const_get("ApiRequestsQuotaReachedError").new if api_requests_quota_reached?(response)

        ApiExceptions.const_get("ForbiddenError").new
      end
    end
  end
end
