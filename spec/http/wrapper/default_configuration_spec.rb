# frozen_string_literal: true

RSpec.describe Http::Wrapper::DefaultConfiguration do
  describe "#connection" do
    it "builds a Faraday connection with the correct URL and headers" do
      connection_builder_double = class_double(Http::Wrapper::ConnectionBuilder, build_faraday_connection: nil)
      headers_configurator_double = class_double(Http::Wrapper::HeadersConfigurator, configure_faraday_headers: nil)

      allow(Http::Wrapper::ConnectionBuilder).to receive(:build_faraday_connection)
                                             .and_return(connection_builder_double)
      allow(Http::Wrapper::HeadersConfigurator).to receive(:configure_faraday_headers)
                                               .and_return(headers_configurator_double)

      configuration = Http::Wrapper::DefaultConfiguration.new(base_url: "http://example.com", api_endpoint: "/api",
                                                       headers: { "Content-Type" => "application/json" })
      configuration.connection(faraday_options: {})

      expect(Http::Wrapper::ConnectionBuilder).to have_received(:build_faraday_connection).with(
        "http://example.com/api", anything
      )
      expect(Http::Wrapper::HeadersConfigurator).to have_received(:configure_faraday_headers)
    end
  end
end
