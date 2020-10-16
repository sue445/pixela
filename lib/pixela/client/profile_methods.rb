module Pixela::Client::ProfileMethods
  # Updates the profile information for the user corresponding to username
  #
  # @param display_name        [String]
  # @param gravatar_icon_email [String]
  # @param title               [String]
  # @param timezone            [String]
  # @param about_url           [String]
  # @param contribute_urls     [Array<String>]
  # @param pinned_graph_id     [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/put-profile
  #
  # @example
  #   client.update_profile(display_name: "a-know", gravatar_icon_email: "user@example.com", title: "my title", timezone: "Asia/Tokyo", about_url: "https://home.a-know.me", contribute_urls: ["https://pixe.la/","https://github.com/a-know/pi","https://blog.a-know.me/archive/category/Pixela"])
  def update_profile(display_name: nil, gravatar_icon_email: nil, title: nil, timezone: nil,
                     about_url: nil, contribute_urls: [], pinned_graph_id: nil)

    params = {
      displayName:       display_name,
      gravatarIconEmail: gravatar_icon_email,
      title:             title,
      timezone:          timezone,
      aboutURL:          about_url,
      pinnedGraphID:     pinned_graph_id
    }

    unless contribute_urls.empty?
      params[:contributeURLs] = contribute_urls
    end

    with_error_handling do
      connection(endpoint: Pixela::Client::TOP_ENDPOINT).put("@#{username}", params.compact).body
    end
  end
end
