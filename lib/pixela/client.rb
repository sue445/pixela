module Pixela
  class Client
    API_ENDPOINT = "https://pixe.la/v1"

    attr_reader :username

    # @param username [String]
    # @param token [String] secret token
    def initialize(username:, token:)
      @username = username
      @token    = token
    end

    # Create a new Pixela user.
    #
    # @param agree_terms_of_service [Boolean]
    # @param not_minor [Boolean]
    #
    # @see https://pixe.la/#api-user
    def register(agree_terms_of_service:, not_minor:)
      params = {
        token:               token,
        username:            username,
        agreeTermsOfService: to_boolean_string(agree_terms_of_service),
        notMinor:            to_boolean_string(not_minor),
      }
      connection.post("users", params, default_headers).body
    end

    private

    attr_reader :token

    def connection
      Faraday.new(API_ENDPOINT) do |conn|
        conn.request :json
        conn.response :mashify
        conn.response :json

        if Pixela.config.debug_logger
          conn.request :curl, Pixela.config.debug_logger, :debug
          conn.response :logger, Pixela.config.debug_logger
        end

        conn.adapter Faraday.default_adapter
      end
    end

    def default_headers
      {
        "User-Agent" => "Pixela v#{Pixela::VERSION}",
      }
    end

    def to_boolean_string(flag)
      flag ? "yes" : "no"
    end
  end
end
