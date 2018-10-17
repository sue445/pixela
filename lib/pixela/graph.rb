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
    # @see https://pixe.la/#api-graph
    #
    # @example
    #   client.graph("test-graph").create(name: "graph-name", unit: "commit", type: "int", color: "shibafu")
    def create(name:, unit:, type:, color:)
      client.create_graph(graph_id: graph_id, name: name, unit: unit, type: type, color: color)
    end

    # Get graph url
    #
    # @param date [Date,Time]
    #
    # @return [String]
    #
    # @see https://pixe.la/#api-graph
    #
    # @example
    #   client.graph("test-graph").url
    #   client.graph("test-graph").url(date: Date.new(2018, 3, 31))
    def url(date: nil)
      client.graph_url(graph_id: graph_id, date: date)
    end

    # Update predefined pixelation graph definitions.
    #
    # @param name  [String]
    # @param unit  [String]
    # @param color [String]
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-graph
    #
    # @example
    #   client.graph("test-graph").update(name: "graph-name", unit: "commit", color: "shibafu")
    def update(name:, unit:, color:)
      client.update_graph(graph_id: graph_id, name: name, unit: unit, color: color)
    end

    # Increment quantity "Pixel" of the day (UTC).
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-pixel
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
    # @see https://pixe.la/#api-pixel
    #
    # @example
    #   client.graph("test-graph").decrement
    def decrement
      client.decrement_pixel(graph_id: graph_id)
    end
  end
end
