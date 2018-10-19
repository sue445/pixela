module Pixela::Client::GraphMethods
  # Create a new pixelation graph definition.
  #
  # @param graph_id [String]
  # @param name     [String]
  # @param unit     [String]
  # @param type     [String]
  # @param color    [String]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-graph
  #
  # @example
  #   client.create_graph(graph_id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu")
  def create_graph(graph_id:, name:, unit:, type:, color:)
    params = {
      id:    graph_id,
      name:  name,
      unit:  unit,
      type:  type,
      color: color,
    }

    with_error_handling do
      connection.post("users/#{username}/graphs", params, user_token_headers).body
    end
  end

  # Get all predefined pixelation graph definitions.
  #
  # @return [Array<Hashie::Mash>]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-graph
  #
  # @example
  #   client.get_graphs
  def get_graphs
    with_error_handling do
      connection.get("users/#{username}/graphs", nil, user_token_headers).body.graphs
    end
  end

  # Get graph url
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  #
  # @return [String]
  #
  # @see https://pixe.la/#api-graph
  #
  # @example
  #   client.graph_url(graph_id: "test-graph")
  #   client.graph_url(graph_id: "test-graph", date: Date.new(2018, 3, 31))
  def graph_url(graph_id:, date: nil)
    url = "#{Pixela::Client::API_ENDPOINT}/users/#{username}/graphs/#{graph_id}"

    url << "?date=#{to_ymd(date)}" if date

    url
  end

  # Update predefined pixelation graph definitions.
  #
  # @param graph_id [String]
  # @param name     [String]
  # @param unit     [String]
  # @param color    [String]
  # @param purge_cache_urls [String,Array<String>]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-graph
  #
  # @example
  #   client.update_graph(graph_id: "test-graph", name: "graph-name", unit: "commit", color: "shibafu", purge_cache_urls: ["https://camo.githubusercontent.com/xxx/xxxx"])
  def update_graph(graph_id:, name:, unit:, color:, purge_cache_urls: nil)
    params = {
      name:  name,
      unit:  unit,
      color: color,
    }

    if purge_cache_urls
      params[:purgeCacheURLs] = Array(purge_cache_urls)
    end

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}", params, user_token_headers).body
    end
  end

  # Delete the predefined pixelation graph definition.
  #
  # @param graph_id [String]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-graph
  #
  # @example
  #   client.delete_graph("test-graph")
  def delete_graph(graph_id)
    with_error_handling do
      connection.delete("users/#{username}/graphs/#{graph_id}", nil, user_token_headers).body
    end
  end
end
