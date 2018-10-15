require "pixela/version"
require "faraday"
require "faraday_middleware"
require "faraday_curl"

module Pixela
  autoload :Client,    "pixela/client"
  autoload :Configure, "pixela/configure"

  # @return [Pixela::Configure]
  def self.config
    @config ||= Configure.new
  end

  class PixelaError < StandardError
  end
end
