module Yuriita
  module Definitions
    class Multiple
      attr_reader :options, :combination

      def initialize(options:, combination:)
        @options = options
        @combination = combination
      end

      def apply(query:)
        selector = MultiSelect.new(options: options, query: query)

        Clauses::Filter.new(filters: selector.filters, combination: combination)
      end

      def view_options(query:, param_key:)
        MultipleCollection.new(
          definition: self,
          query: query,
          formatter: Yuriita::QueryFormatter.new(param_key: param_key),
        ).view_options
      end
    end
  end
end
