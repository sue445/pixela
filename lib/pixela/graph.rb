module Pixela
  class Graph
    # @!attribute [r] client
    # @return [Pixela::Client]
    attr_reader :client

    # @!attribute [r] graph_id
    # @return [String]
    attr_reader :graph_id

    # @param client [Pixela::Client]
    # @param graph_id [String]
    def initialize(client:, graph_id:)
      @client   = client
      @graph_id = graph_id
    end

    # @param date [Date,Time]
    #
    # @return [Pixela::Pixel]
    def pixel(date = Date.today)
      Pixel.new(client: client, graph_id: graph_id, date: date)
    end

    # Create a new pixelation graph definition.
    #
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
    # @see https://docs.pixe.la/#/post-graph
    #
    # @example
    #   client.graph("test-graph").create(name: "graph-name", unit: "commit", type: "int", color: "shibafu", timezone: "Asia/Tokyo", self_sufficient: "increment")
    def create(name:, unit:, type:, color:, timezone: nil, self_sufficient: nil)
      client.create_graph(graph_id: graph_id, name: name, unit: unit, type: type, color: color, timezone: timezone, self_sufficient: self_sufficient)
    end

    # Get graph url
    #
    # @param date [Date,Time]
    # @param mode [String] e.g) `short`
    #
    # @return [String]
    #
    # @see https://docs.pixe.la/#/get-graph
    #
    # @example
    #   client.graph("test-graph").url
    #   client.graph("test-graph").url(date: Date.new(2018, 3, 31), mode: "short")
    def url(date: nil, mode: nil)
      client.graph_url(graph_id: graph_id, date: date, mode: mode)
    end

    # Update predefined pixelation graph definitions.
    #
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
    # @see https://docs.pixe.la/#/put-graph
    #
    # @example
    #   client.graph("test-graph").update(name: "graph-name", unit: "commit", color: "shibafu", timezone: "Asia/Tokyo", purge_cache_urls: ["https://camo.githubusercontent.com/xxx/xxxx"])
    def update(name: nil, unit: nil, color: nil, timezone: nil, purge_cache_urls: nil, self_sufficient: nil)
      client.update_graph(graph_id: graph_id, name: name, unit: unit, color: color, timezone: timezone, self_sufficient: self_sufficient, purge_cache_urls: purge_cache_urls)
    end

    # Delete the predefined pixelation graph definition.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/#/put-graph
    #
    # @example
    #   client.graph("test-graph").delete
    def delete
      client.delete_graph(graph_id)
    end

    # Increment quantity "Pixel" of the day (UTC).
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/#/increment-pixel
    #
    # @example
    #   client.graph("test-graph").increment
    def increment
      client.increment_pixel(graph_id: graph_id)
    end

    # Decrement quantity "Pixel" of the day (UTC).
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/#/decrement-pixel
    #
    # @example
    #   client.graph("test-graph").decrement
    def decrement
      client.decrement_pixel(graph_id: graph_id)
    end
  end
end
