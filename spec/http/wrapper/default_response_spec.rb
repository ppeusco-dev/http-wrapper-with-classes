# frozen_string_literal: true

RSpec.describe Http::Wrapper::DefaultResponse do
  let(:response_body) { '{"message": "success"}' }
  let(:response_status) { 200 }

  describe "#handle" do
    context "when the response is successful" do
      it "returns the parsed response" do
        successful_response = instance_double(Faraday::Response, body: response_body, status: response_status)
        response = Http::Wrapper::DefaultResponse.new(successful_response)
        parsed_response = response.handle

        expect(parsed_response).to eq("message" => "success")
      end
    end

    context "when the response is not successful" do
      it "raises the appropriate exception" do
        error_response = instance_double(Faraday::Response, body: '{"error": "not found"}', status: 404)
        response = Http::Wrapper::DefaultResponse.new(error_response)

        expect { response.handle }.to raise_error(Http::Wrapper::ApiExceptions::NotFoundError)
      end
    end
  end

  describe "#response_successful?" do
    it "returns true for successful responses" do
      successful_response = instance_double(Faraday::Response, status: 200)
      response = Http::Wrapper::DefaultResponse.new(successful_response)

      expect(response.response_successful?).to be(true)
    end

    it "returns false for unsuccessful responses" do
      unsuccessful_response = instance_double(Faraday::Response, status: 404)
      response = Http::Wrapper::DefaultResponse.new(unsuccessful_response)

      expect(response.response_successful?).to be(false)
    end
  end
end
