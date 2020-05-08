module Yuriita
  module Definitions
    class Multiple
      attr_reader :options, :combination

      def initialize(options:, combination:)
        @options = options
        @combination = combination
      end

      def apply(query:)
        filters = selected_filters(query)

        if filters.present?
          Clauses::Filter.new(filters: filters, combination: combination)
        else
          Clauses::Identity.new
        end
      end

      def view_options(query:, param_key:)
        MultipleCollection.new(
          definition: self,
          query: query,
          formatter: Yuriita::QueryFormatter.new(param_key: param_key),
        ).view_options
      end

      private

      def selected_filters(query)
        Selects::Multiple.new(options: options, query: query).filters
      end
    end
  end
end
