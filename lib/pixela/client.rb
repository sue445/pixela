module Pixela
  class Client
    autoload :UserMethods, "pixela/client/user_methods"

    include UserMethods

    API_ENDPOINT = "https://pixe.la/v1"

    attr_reader :username

    # @param username [String]
    # @param token [String] secret token
    def initialize(username:, token:)
      @username = username
      @token    = token
    end

    # @return [String]
    def inspect
      # NOTE: hide @token
      %Q(#<Pixela::Client:0x#{"%016X" % object_id} @username="#{username}">)
    end

    private

    attr_reader :token

    def connection
      Faraday.new(API_ENDPOINT) do |conn|
        conn.request :json
        conn.response :mashify
        conn.response :json
        conn.response :raise_error

        if Pixela.config.debug_logger
          conn.request :curl, Pixela.config.debug_logger, :debug
          conn.response :logger, Pixela.config.debug_logger
        end

        conn.adapter Faraday.default_adapter
      end
    end

    def with_error_handling
      yield
    rescue Faraday::ClientError => error
      begin
        body = JSON.parse(error.response[:body])
        raise PixelaError, body["message"]
      rescue JSON::ParserError
        raise error
      end
    end

    def default_headers
      {
        "User-Agent" => "Pixela v#{Pixela::VERSION} (https://github.com/sue445/pixela)",
        "Content-Type" => "application/json",
      }
    end

    def user_token_headers
      { "X-USER-TOKEN" => token }.merge(default_headers)
    end

    def to_boolean_string(flag)
      flag ? "yes" : "no"
    end
  end
end
