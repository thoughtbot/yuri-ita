module Yuriita
  module Definitions
    class Single
      attr_reader :options

      def initialize(options:)
        @options = options
      end

      def apply(query:)
        selector = SingleSelect.new(options: options, query: query)

        filters = [selector.filter].compact
        Clauses::Filter.new(filters: filters, combination: combination)
      end

      def view_options(query:, param_key:)
        SingleCollection.new(
          definition: self,
          query: query,
          formatter: Yuriita::QueryFormatter.new(param_key: param_key),
        ).view_options
      end

      def combination
        AndCombination
      end
    end
  end
end
