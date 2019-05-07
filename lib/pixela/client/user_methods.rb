module Pixela::Client::UserMethods
  # Create a new Pixela user.
  #
  # @param agree_terms_of_service [Boolean]
  # @param not_minor [Boolean]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/post-user
  #
  # @example
  #   client.create_user(agree_terms_of_service: true, not_minor: true)
  def create_user(agree_terms_of_service:, not_minor:)
    params = {
      token:               token,
      username:            username,
      agreeTermsOfService: to_boolean_string(agree_terms_of_service),
      notMinor:            to_boolean_string(not_minor),
    }

    with_error_handling do
      connection(default_headers).post("users", params).body
    end
  end

  # Updates the authentication token for the specified user.
  #
  # @param new_token [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/put-user
  #
  # @example
  #   client.update_user(new_token: "thisissecret")
  def update_user(new_token:)
    params = {
      newToken: new_token,
    }

    response =
      with_error_handling do
        connection.put("users/#{username}", params).body
      end

    @token = new_token

    response
  end

  # Deletes the specified registered user.
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/delete-user
  #
  # @example
  #   client.delete_user
  def delete_user
    with_error_handling do
      connection.delete("users/#{username}").body
    end
  end
end
