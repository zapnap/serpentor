module Serpentor
  class Rank
    attr_reader :keyword, :host, :url, :value, :requested_at

    def initialize(keyword, host, options={})
      @keyword = keyword
      @host = host
      @limit = options[:limit] || 50
    end

    class << self
      def check(keyword, host, options={})
        new(keyword, host, options).check
      end
    end

    def check
      @requested_at ||= Time.now
      position = 1

      Google::Search::Web.new(query: keyword).each_item do |res|
        return self if !!@value || position > @limit

        if URI.parse(res.uri).host == host
          @value = position
          @url = res.uri
        else
          position += 1
        end
      end

      self
    end

    def rank
      value
    end

    def requested?
      !requested_at.nil?
    end

    def ranked?
      check unless requested?
      !value.nil?
    end

    def unranked?
      check unless requested?
      value.nil?
    end
  end
end
