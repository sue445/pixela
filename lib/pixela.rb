require "pixela/version"
require "faraday"
require "faraday_middleware"
require "faraday_curl"
require "date"

module Pixela
  autoload :Channel,       "pixela/channel"
  autoload :Client,        "pixela/client"
  autoload :Configuration, "pixela/configuration"
  autoload :Graph,         "pixela/graph"
  autoload :Notification,  "pixela/notification"
  autoload :Pixel,         "pixela/pixel"
  autoload :Response,      "pixela/response"
  autoload :Webhook,       "pixela/webhook"

  # @return [Pixela::Configuration]
  def self.config
    @config ||= Configuration.new
  end

  class PixelaError < StandardError
  end
end
