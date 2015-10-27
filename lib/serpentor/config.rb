module Serpentor
  class Config
    attr_accessor :keywords, :host, :limit, :data_store_type, :data_store_id, :client_id, :client_secret

    def initialize
      @keywords = []
      @host = []
      @limit = nil
      @data_store_type = nil
      @data_store_id = nil
      @client_id = nil
      @client_secret = nil
    end
  end
end
