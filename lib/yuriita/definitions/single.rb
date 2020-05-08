module Yuriita
  module Definitions
    class Single
      attr_reader :options

      def initialize(options:)
        @options = options
      end

      def apply(query:)
        filter = selected_filter(query)

        if filter.present?
          Clauses::Filter.new(filters: [filter], combination: combination)
        else
          Clauses::Identity.new
        end
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

      def selected_filter(query)
        Selects::Single.new(options: options, query: query).filter
      end
    end
  end
end
