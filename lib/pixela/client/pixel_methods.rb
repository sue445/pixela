module Pixela::Client::PixelMethods
  # It records the quantity of the specified date as a "Pixel".
  #
  # @param graph_id      [String]
  # @param date          [Date,Time]
  # @param quantity      [Integer,Float]
  # @param optional_data [Object] Additional information other than quantity
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/post-pixel
  #
  # @example
  #   client.create_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15), quantity: 5, optional_data: {key: "value"})
  def create_pixel(graph_id:, date: Date.today, quantity:, optional_data: nil)
    params = {
      date:         to_ymd(date),
      quantity:     quantity.to_s,
      optionalData: optional_data&.to_json,
    }

    with_error_handling do
      connection.post("users/#{username}/graphs/#{graph_id}", compact_hash(params)).body
    end
  end

  # Get registered quantity as "Pixel".
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/get-pixel
  #
  # @example
  #   client.get_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15))
  def get_pixel(graph_id:, date: Date.today)
    with_error_handling do
      connection.get("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}").body
    end
  end

  # Update the quantity already registered as a "Pixel".
  #
  # @param graph_id      [String]
  # @param date          [Date,Time]
  # @param quantity      [Integer,Float]
  # @param optional_data [Object] Additional information other than quantity
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/put-pixel
  #
  # @example
  #   client.update_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15), quantity: 7, optional_data: {key: "value"})
  def update_pixel(graph_id:, date: Date.today, quantity:, optional_data: nil)
    params = {
      quantity:     quantity.to_s,
      optionalData: optional_data&.to_json
    }

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}", compact_hash(params)).body
    end
  end

  # Delete the registered "Pixel".
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/delete-pixel
  #
  # @example
  #   client.delete_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15))
  def delete_pixel(graph_id:, date: Date.today)
    with_error_handling do
      connection.delete("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}").body
    end
  end

  # Increment quantity "Pixel" of the day (UTC).
  #
  # @param graph_id [String]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/increment-pixel
  #
  # @example
  #   client.increment_pixel(graph_id: "test-graph")
  def increment_pixel(graph_id:)
    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/increment").body
    end
  end

  # Decrement quantity "Pixel" of the day (UTC).
  #
  # @param graph_id [String]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/#/decrement-pixel
  #
  # @example
  #   client.decrement_pixel(graph_id: "test-graph")
  def decrement_pixel(graph_id:)
    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/decrement").body
    end
  end
end
