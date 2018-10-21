require "pixela/version"
require "faraday"
require "faraday_middleware"
require "faraday_curl"
require "date"

module Pixela
  autoload :Client,        "pixela/client"
  autoload :Configuration, "pixela/configuration"
  autoload :Graph,         "pixela/graph"
  autoload :Pixel,         "pixela/pixel"
  autoload :Webhook,       "pixela/webhook"

  # @return [Pixela::Configuration]
  def self.config
    @config ||= Configuration.new
  end

  class PixelaError < StandardError
  end
end
