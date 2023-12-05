# frozen_string_literal: true

module Http
  module Wrapper
    module HttpStatusCodes
      OK = :ok
      CREATED = :created
      ACCEPTED = :accepted
      NO_CONTENT = :no_content
      MOVED_PERMANENTLY = :moved_permanently
      FOUND = :found
      NOT_MODIFIED = :not_modified
      TEMPORARY_REDIRECT = :temporary_redirect
      PERMANENT_REDIRECT = :permanent_redirect
      BAD_REQUEST = :bad_request
      UNAUTHORIZED = :unauthorized
      FORBIDDEN = :forbidden
      NOT_FOUND = :not_found
      METHOD_NOT_ALLOWED = :method_not_allowed
      CONFLICT = :conflict
      UNPROCESSABLE_ENTITY = :unprocessable_entity
      TOO_MANY_REQUESTS = :too_many_requests
      INTERNAL_SERVER_ERROR = :internal_server_error
      BAD_GATEWAY = :bad_gateway
      SERVICE_UNAVAILABLE = :service_unavailable
      GATEWAY_TIMEOUT = :gateway_timeout
      DEFAULT = :unknown_status

      SUCCESSFUL_STATUS = [
        OK, CREATED, ACCEPTED,
        NO_CONTENT, MOVED_PERMANENTLY,
        FOUND, NOT_MODIFIED,
        TEMPORARY_REDIRECT, PERMANENT_REDIRECT
      ].freeze

      UNSUCCESSFUL_STATUS = [
        BAD_REQUEST, UNAUTHORIZED, FORBIDDEN,
        NOT_FOUND, METHOD_NOT_ALLOWED, CONFLICT,
        UNPROCESSABLE_ENTITY, TOO_MANY_REQUESTS,
        INTERNAL_SERVER_ERROR, BAD_GATEWAY,
        SERVICE_UNAVAILABLE, GATEWAY_TIMEOUT
      ].freeze
    end

    STATUS_CODE_MAP = {
      200 => :ok,
      201 => :created,
      202 => :accepted,
      204 => :no_content,
      301 => :moved_permanently,
      302 => :found,
      304 => :not_modified,
      307 => :temporary_redirect,
      308 => :permanent_redirect,
      400 => :bad_request,
      401 => :unauthorized,
      403 => :forbidden,
      404 => :not_found,
      405 => :method_not_allowed,
      409 => :conflict,
      422 => :unprocessable_entity,
      429 => :too_many_requests,
      500 => :internal_server_error,
      502 => :bad_gateway,
      503 => :service_unavailable,
      504 => :gateway_timeout,
      default: :unknown_status
    }.freeze

    SUCCESSFUL_STATUS_RANGE = (200..399).freeze
  end
end
