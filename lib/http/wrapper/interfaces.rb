module Http
  module Wrapper
    module Interfaces
      # Interface for configuration
      module Configuration
        def connection
          raise NotImplementedError
        end
      end

      # Interface for request handling
      module Request
        def perform(http_method:, endpoint:, params_type:, params:)
          raise NotImplementedError
        end
      end

      # Interface for response handling
      module Response
        def handle
          raise NotImplementedError
        end

        def response_successful?
          raise NotImplementedError
        end
      end
    end
  end
end
