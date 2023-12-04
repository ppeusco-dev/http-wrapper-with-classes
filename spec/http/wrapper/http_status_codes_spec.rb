# frozen_string_literal: true

RSpec.shared_context "2xx Success" do
  it "defines OK as :ok" do
    expect(described_class::OK).to eq(:ok)
  end

  it "defines CREATED as :created" do
    expect(described_class::CREATED).to eq(:created)
  end

  it "defines ACCEPTED as :accepted" do
    expect(described_class::ACCEPTED).to eq(:accepted)
  end

  it "defines NO_CONTENT as :no_content" do
    expect(described_class::NO_CONTENT).to eq(:no_content)
  end
end

RSpec.shared_context "3xx Redirection" do
  it "defines MOVED_PERMANENTLY as :moved_permanently" do
    expect(described_class::MOVED_PERMANENTLY).to eq(:moved_permanently)
  end

  it "defines FOUND as :found" do
    expect(described_class::FOUND).to eq(:found)
  end

  it "defines NOT_MODIFIED as :not_modified" do
    expect(described_class::NOT_MODIFIED).to eq(:not_modified)
  end

  it "defines TEMPORARY_REDIRECT as :temporary_redirect" do
    expect(described_class::TEMPORARY_REDIRECT).to eq(:temporary_redirect)
  end

  it "defines PERMANENT_REDIRECT as :permanent_redirect" do
    expect(described_class::PERMANENT_REDIRECT).to eq(:permanent_redirect)
  end
end

RSpec.shared_context "4xx Client Errors" do
  it "defines BAD_REQUEST as :bad_request" do
    expect(described_class::BAD_REQUEST).to eq(:bad_request)
  end

  it "defines UNAUTHORIZED as :unauthorized" do
    expect(described_class::UNAUTHORIZED).to eq(:unauthorized)
  end

  it "defines FORBIDDEN as :forbidden" do
    expect(described_class::FORBIDDEN).to eq(:forbidden)
  end

  it "defines NOT_FOUND as :not_found" do
    expect(described_class::NOT_FOUND).to eq(:not_found)
  end

  it "defines METHOD_NOT_ALLOWED as :method_not_allowed" do
    expect(described_class::METHOD_NOT_ALLOWED).to eq(:method_not_allowed)
  end

  it "defines CONFLICT as :conflict" do
    expect(described_class::CONFLICT).to eq(:conflict)
  end

  it "defines UNPROCESSABLE_ENTITY as :unprocessable_entity" do
    expect(described_class::UNPROCESSABLE_ENTITY).to eq(:unprocessable_entity)
  end

  it "defines TOO_MANY_REQUESTS as :too_many_requests" do
    expect(described_class::TOO_MANY_REQUESTS).to eq(:too_many_requests)
  end
end

RSpec.shared_context "5xx Server Errors" do
  it "defines INTERNAL_SERVER_ERROR as :internal_server_error" do
    expect(described_class::INTERNAL_SERVER_ERROR).to eq(:internal_server_error)
  end

  it "defines BAD_GATEWAY as :bad_gateway" do
    expect(described_class::BAD_GATEWAY).to eq(:bad_gateway)
  end

  it "defines SERVICE_UNAVAILABLE as :service_unavailable" do
    expect(described_class::SERVICE_UNAVAILABLE).to eq(:service_unavailable)
  end

  it "defines GATEWAY_TIMEOUT as :gateway_timeout" do
    expect(described_class::GATEWAY_TIMEOUT).to eq(:gateway_timeout)
  end

  it "defines DEFAULT as :unknown_status" do
    expect(described_class::DEFAULT).to eq(:unknown_status)
  end
end

RSpec.describe Http::Wrapper::HttpStatusCodes do
  describe "status codes" do
    context "successful status" do
      include_context "2xx Success"
      include_context "3xx Redirection"
    end

    context "unsuccessful status" do
      include_context "4xx Client Errors"
      include_context "5xx Server Errors"
    end
  end

  describe "status code arrays" do
    it "defines SUCCESSFUL_STATUS with the correct status codes" do
      expect(described_class::SUCCESSFUL_STATUS).to contain_exactly(:ok, :created, :accepted, :no_content,
                                                                    :moved_permanently, :found, :not_modified,
                                                                    :temporary_redirect, :permanent_redirect)
    end

    it "defines UNSUCCESSFUL_STATUS with the correct status codes" do
      expect(described_class::UNSUCCESSFUL_STATUS).to contain_exactly(:bad_request, :unauthorized, :forbidden,
                                                                      :not_found, :method_not_allowed, :conflict,
                                                                      :unprocessable_entity, :too_many_requests,
                                                                      :internal_server_error, :bad_gateway,
                                                                      :service_unavailable, :gateway_timeout)
    end
  end
end
