module Pixela::Client::GraphMethods
  # Create a new pixelation graph definition.
  #
  # @param id    [String]
  # @param name  [String]
  # @param unit  [String]
  # @param type  [String]
  # @param color [String]
  #
  # @return [Hashie::Mash]
  #
  # @see https://pixe.la/#api-graph
  def create_graph(id:, name:, unit:, type:, color:)
    params = {
      id:    id,
      name:  name,
      unit:  unit,
      type:  type,
      color: color,
    }

    with_error_handling do
      connection.post("users/#{username}/graphs", params, user_token_headers).body
    end
  end
end
