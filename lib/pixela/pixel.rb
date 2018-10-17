module Pixela
  class Pixel
    # @!attribute [r] client
    # @return [Pixela::Client]
    attr_reader :client

    # @!attribute [r] graph_id
    # @return [String]
    attr_reader :graph_id

    # @!attribute [r] date
    # @return [Date]
    attr_reader :date

    # @param client   [Pixela::Client]
    # @param graph_id [String]
    # @param date     [Date,Time]
    def initialize(client:, graph_id:, date:)
      @client   = client
      @graph_id = graph_id
      @date     = date
    end

    # It records the quantity of the specified date as a "Pixel".
    #
    # @param quantity [Integer,Float]
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-pixel
    #
    # @example
    #   client.graph("test-graph").pixel(Date.new(2018, 9, 15)).create(quantity: 5)
    def create(quantity:)
      client.create_pixel(graph_id: graph_id, date: date, quantity: quantity)
    end

    # Get registered quantity as "Pixel".
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-pixel
    #
    # @example
    #   client.graph("test-graph").pixel(Date.new(2018, 9, 15)).get
    def get
      client.get_pixel(graph_id: graph_id, date: date)
    end

    # Update the quantity already registered as a "Pixel".
    #
    # @param quantity [Integer,Float]
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-pixel
    #
    # @example
    #   client.graph("test-graph").pixel(Date.new(2018, 9, 15)).update(quantity: 7)
    def update(quantity:)
      client.update_pixel(graph_id: graph_id, date: date, quantity: quantity)
    end

    # Delete the registered "Pixel".
    #
    # @return [Hashie::Mash]
    #
    # @raise [Pixela::PixelaError] API is failed
    #
    # @see https://pixe.la/#api-pixel
    #
    # @example
    #   client.graph("test-graph").pixel(Date.new(2018, 9, 15)).delete
    def delete
      client.delete_pixel(graph_id: graph_id, date: date)
    end
  end
end
