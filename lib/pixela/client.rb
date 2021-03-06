module Pixela
  class Client
    autoload :GraphMethods,        "pixela/client/graph_methods"
    autoload :PixelMethods,        "pixela/client/pixel_methods"
    autoload :ProfileMethods,      "pixela/client/profile_methods"
    autoload :UserMethods,         "pixela/client/user_methods"
    autoload :WebhookMethods,      "pixela/client/webhook_methods"

    include GraphMethods
    include PixelMethods
    include ProfileMethods
    include UserMethods
    include WebhookMethods

    API_ENDPOINT = "https://pixe.la/v1"
    TOP_ENDPOINT = "https://pixe.la"

    # @!attribute [r] username
    # @return [String]
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

    # @param graph_id [String]
    #
    # @return [Pixela::Graph]
    def graph(graph_id)
      Graph.new(client: self, graph_id: graph_id)
    end

    # @param webhook_hash [String]
    #
    # @return [Pixela::Webhook]
    def webhook(webhook_hash)
      Webhook.new(client: self, webhook_hash: webhook_hash)
    end

    private

    # @!attribute [r] token
    # @return [String]
    attr_reader :token

    # @param request_headers [Hash]
    #
    # @return [Faraday::Connection]
    def connection(request_headers: user_token_headers, endpoint: API_ENDPOINT)
      Faraday.new(url: endpoint, headers: request_headers) do |conn|
        conn.request :json
        conn.response :mashify, mash_class: Pixela::Response
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
    rescue Faraday::ClientError, Faraday::ServerError => error
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

    def to_ymd(date)
      return nil unless date

      date.strftime("%Y%m%d")
    end
  end
end
