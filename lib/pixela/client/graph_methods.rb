module Pixela::Client::GraphMethods
  # Create a new pixelation graph definition.
  #
  # @param graph_id        [String]
  # @param name            [String]
  # @param unit            [String]
  # @param type            [String]
  # @param color           [String]
  # @param timezone        [String]
  # @param self_sufficient [String] If SVG graph with this field `increment` or `decrement` is referenced, Pixel of this graph itself will be incremented or decremented
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/post-graph
  #
  # @example
  #   client.create_graph(graph_id: "test-graph", name: "graph-name", unit: "commit", type: "int", color: "shibafu", timezone: "Asia/Tokyo", self_sufficient: "increment")
  def create_graph(graph_id:, name:, unit:, type:, color:, timezone: nil, self_sufficient: nil)
    params = {
      id:             graph_id,
      name:           name,
      unit:           unit,
      type:           type,
      color:          color,
      timezone:       timezone,
      selfSufficient: self_sufficient,
    }

    with_error_handling do
      connection.post("users/#{username}/graphs", compact_hash(params)).body
    end
  end

  # Get all predefined pixelation graph definitions.
  #
  # @return [Array<Hashie::Mash>]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/get-graph
  #
  # @example
  #   client.get_graphs
  def get_graphs
    with_error_handling do
      connection.get("users/#{username}/graphs").body.graphs
    end
  end

  # Get graph url
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  # @param mode     [String] e.g) `short`
  #
  # @return [String]
  #
  # @see https://docs.pixe.la/entry/get-svg
  #
  # @example
  #   client.graph_url(graph_id: "test-graph")
  #   client.graph_url(graph_id: "test-graph", date: Date.new(2018, 3, 31), mode: "short")
  def graph_url(graph_id:, date: nil, mode: nil)
    url = "#{Pixela::Client::API_ENDPOINT}/users/#{username}/graphs/#{graph_id}"

    params = Faraday::Utils::ParamsHash.new
    params[:date] = to_ymd(date) if date
    params[:mode] = mode if mode

    url << "?#{params.to_query}" unless params.empty?

    url
  end

  # Displays graph list by detail in html format.
  #
  # @return [String]
  #
  # @see https://docs.pixe.la/entry/get-graph-list-html
  #
  # @example
  #   client.graphs_url
  def graphs_url
    "https://pixe.la/v1/users/#{username}/graphs.html"
  end

  # Update predefined pixelation graph definitions.
  #
  # @param graph_id         [String]
  # @param name             [String]
  # @param unit             [String]
  # @param color            [String]
  # @param timezone         [String]
  # @param self_sufficient  [String] If SVG graph with this field `increment` or `decrement` is referenced, Pixel of this graph itself will be incremented or decremented
  # @param purge_cache_urls [String,Array<String>]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/put-graph
  #
  # @example
  #   client.update_graph(graph_id: "test-graph", name: "graph-name", unit: "commit", color: "shibafu", timezone: "Asia/Tokyo", self_sufficient: "increment", purge_cache_urls: ["https://camo.githubusercontent.com/xxx/xxxx"])
  def update_graph(graph_id:, name: nil, unit: nil, color: nil, timezone: nil, self_sufficient: nil, purge_cache_urls: nil)
    params = {
      name:           name,
      unit:           unit,
      color:          color,
      timezone:       timezone,
      selfSufficient: self_sufficient,
    }

    if purge_cache_urls
      params[:purgeCacheURLs] = Array(purge_cache_urls)
    end

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}", compact_hash(params)).body
    end
  end

  # Delete the predefined pixelation graph definition.
  #
  # @param graph_id [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/delete-graph
  #
  # @example
  #   client.delete_graph("test-graph")
  def delete_graph(graph_id)
    with_error_handling do
      connection.delete("users/#{username}/graphs/#{graph_id}").body
    end
  end

  # Get a Date list of Pixel registered in the graph specified by graphID.
  #
  # @param graph_id [String]
  # @param from [Date] Specify the start position of the period.
  # @param to   [Date] Specify the end position of the period.
  #
  # @return [Array<Date>]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/get-graph-pixels
  #
  # @example
  #   client.get_pixel_dates(graph_id: "test-graph", from: Date.new(2018, 1, 1), to: Date.new(2018, 12, 31))
  def get_pixel_dates(graph_id:, from: nil, to: nil)
    params = {
      from: to_ymd(from),
      to:   to_ymd(to),
    }

    res =
      with_error_handling do
        connection.get("users/#{username}/graphs/#{graph_id}/pixels", compact_hash(params)).body
      end

    res.pixels.map { |ymd| Date.parse(ymd) }
  end

  # Based on the registered information, get various statistics.
  #
  # @param graph_id [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/get-graph-stats
  #
  # @example
  #   client.get_graph_stats(graph_id: "test-graph")
  def get_graph_stats(graph_id:)
    with_error_handling do
      connection.get("users/#{username}/graphs/#{graph_id}/stats").body
    end
  end
end
