module Pixela
  class Channel
    # @!attribute [r] client
    # @return [Pixela::Client]
    attr_reader :client

    # @!attribute [r] id
    # @return [String]
    attr_reader :id

    # @param client [Pixela::Client]
    # @param graph_id [String]
    def initialize(client:, id:)
      @client = client
      @id     = id
    end

    # Create a new channel settings for notification.
    #
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
    #   client.channel("my-channel").create(name: "My slack channel", type: "slack", detail: {url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", userName: "Pixela Notification", channelName: "pixela-notify"})
    def create(name:, type:, detail:)
      client.create_channel(id: id, name: name, type: type, detail: detail)
    end

    # Create a new channel settings for slack notification.
    #
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
    #   client.channel("my-channel").create_with_slack(name: "My slack channel", url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", user_name: "Pixela Notification", channel_name: "pixela-notify")
    def create_with_slack(name:, url:, user_name:, channel_name:)
      client.create_slack_channel(id: id, name: name, url: url, user_name: user_name, channel_name: channel_name)
    end

    # Update predefined channel settings.
    #
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
    #   client.channel("my-channel").update(name: "My slack channel", type: "slack", detail: {url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", userName: "Pixela Notification", channelName: "pixela-notify"})
    def update(name:, type:, detail:)
      client.update_channel(id: id, name: name, type: type, detail: detail)
    end

    # Update predefined slack channel settings.
    #
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
    #   client.channel("my-channel").update_with_slack(name: "My slack channel", url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", user_name: "Pixela Notification", channel_name: "pixela-notify")
    def update_with_slack(name:, url:, user_name:, channel_name:)
      client.update_slack_channel(id: id, name: name, url: url, user_name: user_name, channel_name: channel_name)
    end

    # Delete predefined channel settings.
    #
    # @see https://docs.pixe.la/entry/delete-channel
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @example
    #   client.channel("my-channel").delete
    def delete
      client.delete_channel(id: id)
    end
  end
end
