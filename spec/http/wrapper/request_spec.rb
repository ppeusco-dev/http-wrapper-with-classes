# frozen_string_literal: true

RSpec.describe Http::Wrapper::Request do
  describe "#perform" do
    it "uses Faraday to make a request" do
      # Crea un doble de instancia para Faraday
      faraday_double = instance_double(Faraday::Connection)

      # Asegúrate de que el doble responda como se espera
      allow(faraday_double).to receive(:public_send)

      # Crea una instancia de tu clase Request usando el doble de instancia de Faraday
      request = Http::Wrapper::Request.new(faraday_double)

      # Llama a #perform
      request.perform(http_method: :get, endpoint: "/example")

      # Verifica que la función correcta de Faraday se llamó con los argumentos correctos
      expect(faraday_double).to have_received(:public_send).with(:get, "/example", {})
    end
  end
end
