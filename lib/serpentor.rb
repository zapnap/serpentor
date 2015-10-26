require "serpentor/config"
require "serpentor/rank"
require "serpentor/version"

require "google-search"

module Serpentor
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Config.new
    yield(configuration)
  end

  def self.rank(options={})
    keywords = options[:keywords]
    host = options[:host]
    limit = options[:limit]

    if configuration
      keywords ||= configuration.keywords
      host ||= configuration.host
      limit ||= configuration.limit
    end

    if keywords.nil? || host.nil?
      raise ArgumentError.new("keywords and host required")
    end

    results = []
    rank_options = {}
    rank_options[:limit] = limit if limit
    keywords = [keywords] if keywords.is_a?(String)

    keywords.each do |keyword|
      results << Rank.check(keyword, host, rank_options)
    end

    results
  end
end
