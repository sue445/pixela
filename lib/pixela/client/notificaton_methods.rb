module Pixela::Client::NotificationMethods
  # Create a notification rule.
  #
  # @param graph_id [String]
  # @param notification_id [String]
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
  #   client.create_notification(graph_id: "test-graph", notification_id: "my-notification-rule", name: "my notification rule", target: "quantity", condition: ">", threshold: "5", remind_by: "21", channel_id: "my-channel")
  def create_notification(graph_id:, notification_id:, name:, target:, condition:, threshold:, remind_by: nil, channel_id:)
    params = {
      id: notification_id,
      name: name,
      target: target,
      condition: condition,
      threshold: threshold,
      remindBy: remind_by,
      channelID: channel_id,
    }

    with_error_handling do
      connection.post("users/#{username}/graphs/#{graph_id}/notifications", compact_hash(params)).body
    end
  end

  # Get all predefined notifications.
  #
  # @param graph_id [String]
  #
  # @return [Array<Pixela::Response>]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/get-notifications
  #
  # @example
  #   client.get_notifications(graph_id: "test-graph")
  def get_notifications(graph_id:)
    with_error_handling do
      connection.get("users/#{username}/graphs/#{graph_id}/notifications").body.notifications
    end
  end

  # Update predefined notification rule.
  #
  # @param graph_id [String]
  # @param notification_id [String]
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
  #   client.update_notification(graph_id: "test-graph", notification_id: "my-notification-rule", name: "my notification rule", target: "quantity", condition: ">", threshold: "5", channel_id: "my-channel")
  def update_notification(graph_id:, notification_id:, name:, target:, condition:, threshold:, channel_id:)
    params = {
      name: name,
      target: target,
      condition: condition,
      threshold: threshold,
      channelID: channel_id,
    }

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/notifications/#{notification_id}", compact_hash(params)).body
    end
  end

  # Delete predefined notification settings.
  #
  # @param graph_id [String]
  # @param notification_id [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/delete-notification
  #
  # @example
  #   client.delete_notification(graph_id: "test-graph", notification_id: "my-notification-rule")
  def delete_notification(graph_id:, notification_id:)
    with_error_handling do
      connection.delete("users/#{username}/graphs/#{graph_id}/notifications/#{notification_id}").body
    end
  end
end
