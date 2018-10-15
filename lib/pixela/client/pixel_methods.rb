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
  def create_pixel(graph_id:, date:, quantity:)
    params = {
      date:     to_ymd(date),
      quantity: quantity.to_s,
    }

    with_error_handling do
      connection.post("users/#{username}/graphs/#{graph_id}", params, user_token_headers).body
    end
  end
end
