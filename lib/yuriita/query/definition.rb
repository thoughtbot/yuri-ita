module Yuriita
  class Query
    class Definition
      attr_reader :filters

      def initialize(filters:)
        @filters = filters
      end
    end
  end
end
