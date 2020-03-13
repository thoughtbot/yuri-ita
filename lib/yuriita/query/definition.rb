module Yuriita
  class Query
    class Definition
      attr_reader :expression_filters, :keyword_filters

      def initialize(expression_filters: [], keyword_filters: [])
        @expression_filters = expression_filters
        @keyword_filters = keyword_filters
      end
    end
  end
end
