module Yuriita
  class Query
    class Definition
      attr_reader :filters, :searches

      def initialize(filters: [], searches: [])
        @filters = filters
        @searches = searches
      end
    end
  end
end
