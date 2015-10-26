module Serpentor
  class Config
    attr_accessor :keywords, :host, :limit

    def initialize
      @keywords = []
      @host = []
      @limit = nil
    end
  end
end
