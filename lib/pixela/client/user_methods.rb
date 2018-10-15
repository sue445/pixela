module Pixela::Client::UserMethods
  # Create a new Pixela user.
  #
  # @param agree_terms_of_service [Boolean]
  # @param not_minor [Boolean]
  #
  # @see https://pixe.la/#api-user
  def create_user(agree_terms_of_service:, not_minor:)
    params = {
      token:               token,
      username:            username,
      agreeTermsOfService: to_boolean_string(agree_terms_of_service),
      notMinor:            to_boolean_string(not_minor),
    }

    with_error_handling do
      connection.post("users", params, default_headers).body
    end
  end
end
