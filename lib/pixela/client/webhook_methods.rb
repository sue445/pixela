module Pixela::Client::WebhookMethods
  # Create a new Webhook.
  #
  # @param graph_id [String]
  # @param type     [String]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-webhook
  #
  # @example
  #   client.create_webhook(graph_id: "test-graph", type: "increment")
  def create_webhook(graph_id:, type:)
    params = {
      graphID: graph_id,
      type:    type,
    }

    with_error_handling do
      connection.post("users/#{username}/webhooks", params, user_token_headers).body
    end
  end

  # Get all predefined webhooks definitions.
  #
  # @return [Array<Hashie::Mash>]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-webhook
  #
  # @example
  #   client.get_webhooks
  def get_webhooks
    with_error_handling do
      connection.get("users/#{username}/webhooks", nil, user_token_headers).body.webhooks
    end
  end

  # Invoke the webhook registered in advance.
  #
  # @param webhook_hash [String]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-webhook
  #
  # @example
  #   client.invoke_webhook(webhook_hash: "<webhookHash>")
  def invoke_webhook(webhook_hash:)
    with_error_handling do
      connection.post("users/#{username}/webhooks/#{webhook_hash}", nil, default_headers).body
    end
  end

  # Delete the registered Webhook.
  #
  # @param webhook_hash [String]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-webhook
  #
  # @example
  #   client.delete_webhook(webhook_hash: "<webhookHash>")
  def delete_webhook(webhook_hash:)
    with_error_handling do
      connection.delete("users/#{username}/webhooks/#{webhook_hash}", nil, user_token_headers).body
    end
  end
end
