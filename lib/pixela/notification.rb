module Pixela
  class Notification
    # @!attribute [r] client
    # @return [Pixela::Client]
    attr_reader :client

    # @!attribute [r] graph_id
    # @return [String]
    attr_reader :graph_id

    # @!attribute [r] notification_id
    # @return [String]
    attr_reader :notification_id

    # @param client          [Pixela::Client]
    # @param graph_id        [String]
    # @param notification_id [String]
    def initialize(client:, graph_id:, notification_id:)
      @client          = client
      @graph_id        = graph_id
      @notification_id = notification_id
    end

    # Create a notification rule.
    #
    # @param name [String]
    # @param target [String]
    # @param condition [String]
    # @param threshold [String]
    # @param remind_by [String]
    # @param channel_id [String]
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/post-notification
    #
    # @example
    #   client.graph("test-graph").notification("my-notification-rule").create(name: "my notification rule", target: "quantity", condition: ">", threshold: "5", remind_by: "21", channel_id: "my-channel")
    def create(name:, target:, condition:, threshold:, remind_by: nil, channel_id:)
      client.create_notification(graph_id: graph_id, notification_id: notification_id, name: name, target: target, condition: condition, threshold: threshold, remind_by: remind_by, channel_id: channel_id)
    end

    # Update predefined notification rule.
    #
    # @param name [String]
    # @param target [String]
    # @param condition [String]
    # @param threshold [String]
    # @param channel_id [String]
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/put-notification
    #
    # @example
    #   client.graph("test-graph").notification("my-notification-rule").update(name: "my notification rule", target: "quantity", condition: ">", threshold: "5", channel_id: "my-channel")
    def update(name:, target:, condition:, threshold:, channel_id:)
      client.update_notification(graph_id: graph_id, notification_id: notification_id, name: name, target: target, condition: condition, threshold: threshold, channel_id: channel_id)
    end

    # Delete predefined notification settings.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/delete-notification
    #
    # @example
    #   client.graph("test-graph").notification("my-notification-rule").delete
    def delete
      client.delete_notification(graph_id: graph_id, notification_id: notification_id)
    end
  end
end
