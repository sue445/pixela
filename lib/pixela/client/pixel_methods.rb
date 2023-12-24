module Pixela::Client::PixelMethods
  # It records the quantity of the specified date as a "Pixel".
  #
  # @param graph_id      [String]
  # @param date          [Date,Time]
  # @param quantity      [Integer,Float]
  # @param optional_data [Object] Additional information other than quantity
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/post-pixel
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
      connection.post("users/#{username}/graphs/#{graph_id}", params.compact).body
    end
  end

  # This API is used to register multiple Pixels (quantities for a specific day) at a time.
  #
  # @param graph_id [String]
  # @param pixels   [Array<Hash>] key: date, quantity, optional_data
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/batch-post-pixels
  #
  # @example
  #   client.create_pixels(graph_id: "test-graph", pixels: [{date: Date.new(2018, 9, 15), quantity: 5, optional_data: {key: "value"}}])
  def create_pixels(graph_id:, pixels:)
    pixels = pixels.map do |pixel|
      {
        date:         to_ymd(pixel[:date]),
        quantity:     pixel[:quantity].to_s,
        optionalData: pixel[:optional_data]&.to_json,
      }.compact
    end

    with_error_handling do
      connection.post("users/#{username}/graphs/#{graph_id}/pixels", pixels).body
    end
  end

  # Get registered quantity as "Pixel".
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/get-pixel
  #
  # @example
  #   client.get_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15))
  def get_pixel(graph_id:, date: Date.today)
    res =
      with_error_handling do
        connection.get("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}").body
      end

    if res.key?(:optionalData)
      res[:optional_data] =
        begin
          JSON.parse(res[:optionalData])
        rescue JSON::ParserError
          res[:optionalData]
        end
      res.delete(:optionalData)
    end

    res
  end

  # Update the quantity already registered as a "Pixel".
  #
  # @param graph_id      [String]
  # @param date          [Date,Time]
  # @param quantity      [Integer,Float]
  # @param optional_data [Object] Additional information other than quantity
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/put-pixel
  #
  # @example
  #   client.update_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15), quantity: 7, optional_data: {key: "value"})
  def update_pixel(graph_id:, date: Date.today, quantity:, optional_data: nil)
    params = {
      quantity:     quantity.to_s,
      optionalData: optional_data&.to_json
    }

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}", params.compact).body
    end
  end

  # Delete the registered "Pixel".
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/delete-pixel
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
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/increment-pixel
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
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/decrement-pixel
  #
  # @example
  #   client.decrement_pixel(graph_id: "test-graph")
  def decrement_pixel(graph_id:)
    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/decrement").body
    end
  end

  # Add quantity to the "Pixel" of the day
  #
  # @param graph_id [String]
  # @param quantity [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/add-pixel
  #
  # @example
  #   client.add_pixel(graph_id: "test-graph", quantity: "1")
  def add_pixel(graph_id:, quantity:)
    params = {
      quantity: quantity.to_s,
    }

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/add", params.compact).body
    end
  end

  # Subtract quantity from the "Pixel" of the day
  #
  # @param graph_id [String]
  # @param quantity [String]
  #
  # @return [Pixela::Response]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://docs.pixe.la/entry/subtract-pixel
  #
  # @example
  #   client.subtract_pixel(graph_id: "test-graph", quantity: "1")
  def subtract_pixel(graph_id:, quantity:)
    params = {
      quantity: quantity.to_s,
    }

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/subtract", params.compact).body
    end
  end
end
