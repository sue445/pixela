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
    # @param name  [String]
    # @param unit  [String]
    # @param type  [String]
    # @param color [String]
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-detail-post-graphs
    #
    # @example
    #   client.graph("test-graph").create(name: "graph-name", unit: "commit", type: "int", color: "shibafu")
    def create(name:, unit:, type:, color:)
      client.create_graph(graph_id: graph_id, name: name, unit: unit, type: type, color: color)
    end

    # Get graph url
    #
    # @param date [Date,Time]
    # @param mode [String] e.g) `short`
    #
    # @return [String]
    #
    # @see https://pixe.la/#api-detail-get-graph
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
    # @param purge_cache_urls [String,Array<String>]
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-detail-put-graph
    #
    # @example
    #   client.graph("test-graph").update(name: "graph-name", unit: "commit", color: "shibafu", purge_cache_urls: ["https://camo.githubusercontent.com/xxx/xxxx"])
    def update(name:, unit:, color:, purge_cache_urls: nil)
      client.update_graph(graph_id: graph_id, name: name, unit: unit, color: color, purge_cache_urls: purge_cache_urls)
    end

    # Increment quantity "Pixel" of the day (UTC).
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-detail-pixel-increment
    #
    # @example
    #   client.graph("test-graph").increment
    def increment
      client.increment_pixel(graph_id: graph_id)
    end

    # Decrement quantity "Pixel" of the day (UTC).
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-detail-pixel-decrement
    #
    # @example
    #   client.graph("test-graph").decrement
    def decrement
      client.decrement_pixel(graph_id: graph_id)
    end
  end
end
