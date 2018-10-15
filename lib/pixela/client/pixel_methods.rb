module Pixela::Client::PixelMethods
  # It records the quantity of the specified date as a "Pixel".
  #
  # @param graph_id [String]
  # @param date     [Date,Time]
  # @param quantity [Integer,Float]
  #
  # @return [Hashie::Mash]
  #
  # @see https://pixe.la/#api-pixel
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
  # @see https://pixe.la/#api-pixel
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
  # @see https://pixe.la/#api-pixel
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
  # @see https://pixe.la/#api-pixel
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
  # @see https://pixe.la/#api-pixel
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
  # @see https://pixe.la/#api-pixel
  def decrement_pixel(graph_id:)
    with_error_handling do
      connection.put("users/#{username}/graphs/#{graph_id}/decrement", nil, user_token_headers).body
    end
  end
end
