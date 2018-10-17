module Pixela::Client::PixelMethods
  # It records the quantity of the specified date as a "Pixel".
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  # @param quantity [Integer,Float]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-pixel
  #
  # @example
  #   client.create_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15), quantity: 5)
  def create_pixel(graph_id:, date: Date.today, quantity:)
    params = {
      date:     to_ymd(date),
      quantity: quantity.to_s,
    }

    with_error_handling do
      connection.post("users/#{username}/graphs/#{graph_id}", params, user_token_headers).body
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
  # @see https://pixe.la/#api-pixel
  #
  # @example
  #   client.get_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15))
  def get_pixel(graph_id:, date: Date.today)
    with_error_handling do
      connection.get("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}", nil, user_token_headers).body
    end
  end

  # Update the quantity already registered as a "Pixel".
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  # @param quantity [Integer,Float]
  #
  # @return [Hashie::Mash]
  #
  # @raise [Pixela::PixelaError] API is failed
  #
  # @see https://pixe.la/#api-pixel
  #
  # @example
  #   client.update_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15), quantity: 7)
  def update_pixel(graph_id:, date: Date.today, quantity:)
    params = {
      quantity: quantity.to_s,
    }

    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}", params, user_token_headers).body
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
  # @see https://pixe.la/#api-pixel
  #
  # @example
  #   client.delete_pixel(graph_id: "test-graph", date: Date.new(2018, 9, 15))
  def delete_pixel(graph_id:, date: Date.today)
    with_error_handling do
      connection.delete("users/#{username}/graphs/#{graph_id}/#{to_ymd(date)}", nil, user_token_headers).body
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
  # @see https://pixe.la/#api-pixel
  #
  # @example
  #   client.increment_pixel(graph_id: "test-graph")
  def increment_pixel(graph_id:)
    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/increment", nil, user_token_headers).body
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
  # @see https://pixe.la/#api-pixel
  #
  # @example
  #   client.decrement_pixel(graph_id: "test-graph")
  def decrement_pixel(graph_id:)
    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/decrement", nil, user_token_headers).body
    end
  end
end
