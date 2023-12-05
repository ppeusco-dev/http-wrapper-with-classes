# frozen_string_literal: true

require "rspec"
require "webmock/rspec"

RSpec.describe Http::Wrapper::Client do
  let(:base_url) { "https://api.example.com" }
  let(:api_endpoint) { "/endpoint" }
  let(:headers) { { "Content-Type" => "application/json" } }
  let(:client) { described_class.new(base_url: base_url, api_endpoint: api_endpoint, headers: headers) }

  describe "#request" do
    context "when the request is successful" do
      before do
        stub_request(:get, "#{base_url}#{api_endpoint}")
          .with(headers: headers)
          .to_return(status: 200, body: '{"message": "success"}', headers: { 'Content-Type': "application/json" })
      end

      it "returns the parsed response" do
        response = client.request(http_method: :get, endpoint: api_endpoint)
        expect(response).to eq({ "message" => "success" })
      end
    end

    context "when the request is unsuccessful" do
      before do
        stub_request(:get, "#{base_url}#{api_endpoint}")
          .with(headers: headers)
          .to_return(status: 404, body: '{"error": "not found"}', headers: { 'Content-Type': "application/json" })
      end

      it "raises the appropriate exception" do
        expect { client.request(http_method: :get, endpoint: api_endpoint) }
          .to raise_error(Http::Wrapper::ApiExceptions::NotFoundError)
      end
    end
  end
end
