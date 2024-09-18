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
    # @param name                  [String]
    # @param unit                  [String]
    # @param type                  [String]
    # @param color                 [String]
    # @param timezone              [String]
    # @param self_sufficient       [String] If SVG graph with this field `increment` or `decrement` is referenced, Pixel of this graph itself will be incremented or decremented
    # @param is_secret             [Boolean]
    # @param publish_optional_data [Boolean]
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/post-graph
    #
    # @example
    #   client.graph("test-graph").create(name: "graph-name", unit: "commit", type: "int", color: "shibafu", timezone: "Asia/Tokyo", self_sufficient: "increment", is_secret: true, publish_optional_data: true)
    def create(name:, unit:, type:, color:, timezone: nil, self_sufficient: nil, is_secret: nil, publish_optional_data: nil)
      client.create_graph(
        graph_id: graph_id, name: name, unit: unit, type: type, color: color, timezone: timezone, self_sufficient: self_sufficient,
        is_secret: is_secret, publish_optional_data: publish_optional_data,
      )
    end

    # Get graph url
    #
    # @param date         [Date,Time]
    # @param mode         [String] e.g) `short`
    # @param appearance   [String] e.g) `dark`
    # @param less_than    [String]
    # @param greater_than [String]
    #
    # @return [String]
    #
    # @see https://docs.pixe.la/entry/get-graph
    #
    # @example
    #   client.graph("test-graph").url
    #   client.graph("test-graph").url(date: Date.new(2018, 3, 31), mode: "short")
    def url(date: nil, mode: nil, appearance: nil, less_than: nil, greater_than: nil)
      client.graph_url(graph_id: graph_id, date: date, mode: mode, appearance: appearance, less_than: less_than, greater_than: greater_than)
    end

    # Update predefined pixelation graph definitions.
    #
    # @param name                  [String]
    # @param unit                  [String]
    # @param color                 [String]
    # @param timezone              [String]
    # @param self_sufficient       [String] If SVG graph with this field `increment` or `decrement` is referenced, Pixel of this graph itself will be incremented or decremented
    # @param purge_cache_urls      [String,Array<String>]
    # @param is_secret             [Boolean]
    # @param publish_optional_data [Boolean]
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/put-graph
    #
    # @example
    #   client.graph("test-graph").update(name: "graph-name", unit: "commit", color: "shibafu", timezone: "Asia/Tokyo", purge_cache_urls: ["https://camo.githubusercontent.com/xxx/xxxx"])
    def update(name: nil, unit: nil, color: nil, timezone: nil, purge_cache_urls: nil, self_sufficient: nil, is_secret: nil, publish_optional_data: nil)
      client.update_graph(
        graph_id: graph_id, name: name, unit: unit, color: color, timezone: timezone, self_sufficient: self_sufficient,
        purge_cache_urls: purge_cache_urls, is_secret: is_secret, publish_optional_data: publish_optional_data,
      )
    end

    # Delete the predefined pixelation graph definition.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/put-graph
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
    # @see https://docs.pixe.la/entry/increment-pixel
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
    # @see https://docs.pixe.la/entry/decrement-pixel
    #
    # @example
    #   client.graph("test-graph").decrement
    def decrement
      client.decrement_pixel(graph_id: graph_id)
    end

    # Add quantity to the "Pixel" of the day
    #
    # @param quantity [String]
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/add-pixel
    #
    # @example
    #   client.graph("test-graph").add(quantity: "1")
    def add(quantity:)
      client.add_pixel(graph_id: graph_id, quantity: quantity)
    end

    # Subtract quantity from the "Pixel" of the day
    #
    # @param quantity [String]
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/subtract-pixel
    #
    # @example
    #   client.graph("test-graph").subtract(quantity: "1")
    def subtract(quantity:)
      client.subtract_pixel(graph_id: graph_id, quantity: quantity)
    end

    # Get a Date list of Pixel registered in the graph specified by graphID.
    #
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
    #   client.graph("test-graph").pixel_dates(from: Date.new(2018, 1, 1), to: Date.new(2018, 12, 31))
    def pixel_dates(from: nil, to: nil)
      client.get_pixel_dates(graph_id: graph_id, from: from, to: to)
    end

    # Get a Date list of Pixel registered in the graph specified by graphID.
    #
    # @param from [Date] Specify the start position of the period.
    # @param to   [Date] Specify the end position of the period.
    #
    # @return [Array<Hashie::Mash>]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/get-graph-pixels
    #
    # @example
    #   client.graph("test-graph").pixels(from: Date.new(2018, 1, 1), to: Date.new(2018, 12, 31))
    def pixels(from: nil, to: nil)
      client.get_pixels(graph_id: graph_id, from: from, to: to)
    end

    # Based on the registered information, get various statistics.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/get-graph-stats
    #
    # @example
    #   client.graph("test-graph").stats
    def stats
      client.get_graph_stats(graph_id: graph_id)
    end

    # This will start and end the measurement of the time.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/post-stopwatch
    #
    # @example
    #   client.graph("test-graph").run_stopwatch
    def run_stopwatch
      client.run_stopwatch(graph_id: graph_id)
    end

    alias_method :start_stopwatch, :run_stopwatch
    alias_method :end_stopwatch,   :run_stopwatch

    # Get a predefined pixelation graph definition.
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/get-a-graph-def
    #
    # @example
    #   client.graph("test-graph").def
    def def
      client.get_graph_def(graph_id: graph_id)
    end

    alias_method :definition, :def

    # This API is used to get latest Pixel of the graph which specified by <graphID> .
    #
    # @return [Pixela::Response]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://docs.pixe.la/entry/get-latest-pixel
    #
    # @example
    #   client.graph("test-graph").latest
    def latest
      client.get_graph_latest(graph_id: graph_id)
    end
  end
end
