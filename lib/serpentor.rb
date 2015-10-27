require "serpentor/config"
require "serpentor/rank"
require "serpentor/data_store"
require "serpentor/version"

require "extlib"
require "google-search"
require "google/api_client"
require "google_drive"

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

    if configuration && configuration.data_store_type
      begin
        data_store_type = Extlib::Inflection.camelize(configuration.data_store_type)
        data_store_klass = Object.const_get("Serpentor::DataStore::#{data_store_type}")
      rescue NameError
        raise Serpentor::DataStoreError.new("Unable to find data store with type '#{configuration.data_store_type}'")
      end

      data_store_id = configuration.data_store_id
      data_store = data_store_klass.new(data_store_id)

      if !data_store.exists?
        data_store_id = data_store.create
        puts data_store_id
      end

      data_store.update(results)
    end

    results
  end

  class Error < ::StandardError; end
  class DataStoreError < Error; end
end
