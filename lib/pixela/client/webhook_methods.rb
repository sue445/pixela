module Pixela::Client::WebhookMethods
  # Create a new Webhook.
  #
  # @param graph_id [String]
  # @param type     [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/post-webhook
  #
  # @example
  #   client.create_webhook(graph_id: "test-graph", type: "increment")
  def create_webhook(graph_id:, type:)
    params = {
      graphID: graph_id,
      type:    type,
    }

    with_error_handling do
      connection.post("users/#{username}/webhooks", params).body
    end
  end

  # Get all predefined webhooks definitions.
  #
  # @return [Array<Hashie::Mash>]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/get-webhooks
  #
  # @example
  #   client.get_webhooks
  def get_webhooks
    with_error_handling do
      connection.get("users/#{username}/webhooks").body.webhooks
    end
  end

  # Invoke the webhook registered in advance.
  #
  # @param webhook_hash [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/invoke-webhook
  #
  # @example
  #   client.invoke_webhook(webhook_hash: "<webhookHash>")
  def invoke_webhook(webhook_hash:)
    with_error_handling do
      connection(default_headers).post("users/#{username}/webhooks/#{webhook_hash}").body
    end
  end

  # Delete the registered Webhook.
  #
  # @param webhook_hash [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/delete-webhook
  #
  # @example
  #   client.delete_webhook(webhook_hash: "<webhookHash>")
  def delete_webhook(webhook_hash:)
    with_error_handling do
      connection.delete("users/#{username}/webhooks/#{webhook_hash}").body
    end
  end
end
