module Pixela::Client::ChannelMethods
  # Create a new channel settings for notification.
  #
  # @param channel_id [String]
  # @param name [String]
  # @param type [String]
  # @param detail [Hash]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/post-channel
  #
  # @example
  #   client.create_channel(channel_id: "my-channel", name: "My slack channel", type: "slack", detail: {url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", userName: "Pixela Notification", channelName: "pixela-notify"})
  def create_channel(channel_id:, name:, type:, detail:)
    params = {
      id:     channel_id,
      name:   name,
      type:   type,
      detail: detail,
    }

    with_error_handling do
      connection.post("users/#{username}/channels", compact_hash(params)).body
    end
  end

  # Create a new channel settings for slack notification.
  #
  # @param channel_id [String]
  # @param name [String]
  # @param url [String]
  # @param user_name [String]
  # @param channel_name [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/post-channel
  #
  # @example
  #   client.create_slack_channel(channel_id: "my-channel", name: "My slack channel", url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", user_name: "Pixela Notification", channel_name: "pixela-notify")
  def create_slack_channel(channel_id:, name:, url:, user_name:, channel_name:)
    create_channel(
      channel_id: channel_id,
      name: name,
      type: "slack",
      detail: {
        url:         url,
        userName:    user_name,
        channelName: channel_name,
      },
    )
  end

  # Get all predefined channels.
  #
  # @see https://docs.pixe.la/entry/get-channels
  #
  # @return [Array<Pixela::Response>]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @example
  #   client.get_channels
  def get_channels
    with_error_handling do
      connection.get("users/#{username}/channels").body.channels
    end
  end

  # Update predefined channel settings.
  #
  # @param channel_id [String]
  # @param name [String]
  # @param type [String]
  # @param detail [Hash]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/put-channel
  #
  # @example
  #   client.update_channel(channel_id: "my-channel", name: "My slack channel", type: "slack", detail: {url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", userName: "Pixela Notification", channelName: "pixela-notify"})
  def update_channel(channel_id:, name:, type:, detail:)
    params = {
      name:   name,
      type:   type,
      detail: detail,
    }

    with_error_handling do
      connection.put("users/#{username}/channels/#{channel_id}", compact_hash(params)).body
    end
  end

  # Update predefined slack channel settings.
  #
  # @param channel_id [String]
  # @param name [String]
  # @param url [String]
  # @param user_name [String]
  # @param channel_name [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/post-channel
  #
  # @example
  #   client.update_slack_channel(channel_id: "my-channel", name: "My slack channel", url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", user_name: "Pixela Notification", channel_name: "pixela-notify")
  def update_slack_channel(channel_id:, name:, url:, user_name:, channel_name:)
    update_channel(
      channel_id: channel_id,
      name: name,
      type: "slack",
      detail: {
        url:         url,
        userName:    user_name,
        channelName: channel_name,
      },
    )
  end

  # Delete predefined channel settings.
  #
  # @param channel_id [String]
  #
  # @see https://docs.pixe.la/entry/delete-channel
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @example
  #   client.delete_channel(channel_id: "my-channel")
  def delete_channel(channel_id:)
    with_error_handling do
      connection.delete("users/#{username}/channels/#{channel_id}").body
    end
  end
end
