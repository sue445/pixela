module Pixela
  class Webhook
    # @!attribute [r] client
    # @return [Pixela::Client]
    attr_reader :client

    # @!attribute [r] webhook_hash
    # @return [String]
    attr_reader :webhook_hash

    # @param client       [Pixela::Client]
    # @param webhook_hash [String]
    def initialize(client:, webhook_hash:)
      @client       = client
      @webhook_hash = webhook_hash
    end

    # Invoke the webhook registered in advance.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/invoke-webhook
    #
    # @example
    #   client.webhook("<webhookHash>").invoke
    def invoke
      client.invoke_webhook(webhook_hash: webhook_hash)
    end

    # Delete the registered Webhook.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/delete-webhook
    #
    # @example
    #   client.webhook("<webhookHash>").delete
    def delete
      client.delete_webhook(webhook_hash: webhook_hash)
    end
  end
end
