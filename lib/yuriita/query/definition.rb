module Yuriita
  class Query
    class Definition
      attr_reader :expression_filters, :keyword_filters, :sorters

      def initialize(expression_filters: [], keyword_filters: [], sorters: [])
        @expression_filters = expression_filters
        @keyword_filters = keyword_filters
        @sorters = sorters
      end
    end
  end
end
