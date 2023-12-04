# frozen_string_literal: true

RSpec.describe Http::Wrapper::ApiExceptions do
  shared_context "client error context" do |error_class, error_message|
    it "is a client error with the correct message" do
      error = error_class.new
      expect(error.message).to eq(error_message)
    end
  end

  context "4xx Client Errors" do
    include_context "client error context", Http::Wrapper::ApiExceptions::BadRequestError, "Bad Request"
    include_context "client error context", Http::Wrapper::ApiExceptions::UnauthorizedError, "Unauthorized"
    include_context "client error context", Http::Wrapper::ApiExceptions::ForbiddenError, "Forbidden"
    include_context "client error context", Http::Wrapper::ApiExceptions::NotFoundError, "Not Found"
    include_context "client error context", Http::Wrapper::ApiExceptions::UnprocessableEntityError,
                    "Unprocessable Entity"
    include_context "client error context", Http::Wrapper::ApiExceptions::ApiRequestsQuotaReachedError,
                    "API rate limit exceeded"
  end
end

RSpec.describe Http::Wrapper::ApiExceptions do
  shared_context "server error context" do |error_class, error_message|
    it "is a server error with the correct message" do
      error = error_class.new
      expect(error.message).to eq(error_message)
    end
  end

  context "5xx Server Errors" do
    include_context "server error context", Http::Wrapper::ApiExceptions::InternalServerError, "Internal Server Error"
    include_context "server error context", Http::Wrapper::ApiExceptions::BadGatewayError, "Bad Gateway"
    include_context "server error context", Http::Wrapper::ApiExceptions::ServiceUnavailableError, "Service Unavailable"
    include_context "server error context", Http::Wrapper::ApiExceptions::GatewayTimeoutError, "Gateway Timeout"
  end
end

# Especificaciones adicionales
RSpec.describe Http::Wrapper::ApiExceptions::UnknownStatusError do
  it "has the correct message based on status" do
    status = 404
    error = described_class.new(status)
    expect(error.message).to eq("Unknown Status: 404")
  end
end
