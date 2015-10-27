module Serpentor
  module DataStore
    class Base
      attr_reader :key, :data

      def initialize(key, data=[])
        @key = key
        @data = data
      end

      def exists?
        !key.nil?
      end

      def create
      end

      def update(data)
      end
    end
  end
end

module Serpentor
  module DataStore
    class GoogleSheet < Base
      attr_reader :session

      def create
        spreadsheet = session.create_spreadsheet('SERP')
        @key = spreadsheet.key
        ws = spreadsheet.worksheets[0]

        # Headers
        ws[1, 1] = "Keyword"
        ws[1, 2] = "URL"
        ws[1, 3] = "Rank"
        ws[1, 4] = "Date"
        ws.save

        @key
      end

      def update(data)
        spreadsheet = session.spreadsheet_by_key(key)
        ws = spreadsheet.worksheets[0]

        data.each_with_index do |res, index|
          row = index + 2
          ws[row, 1] = res.keyword
          ws[row, 2] = res.url
          ws[row, 3] = res.rank
          ws[row, 4] = Time.now.to_date
        end

        ws.save
      end

      private

      def session
        @session = GoogleDrive.saved_session("./stored_token.json", nil, Serpentor.configuration.client_id, Serpentor.configuration.client_secret)
      end
    end
  end
end
