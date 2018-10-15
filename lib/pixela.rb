require "pixela/version"
require "faraday"
require "faraday_middleware"
require "faraday_curl"

module Pixela
  autoload :Client,    "pixela/client"
  autoload :Configuration, "pixela/configuration"

  # @return [Pixela::Configuration]
  def self.config
    @config ||= Configuration.new
  end

  class PixelaError < StandardError
  end
end
