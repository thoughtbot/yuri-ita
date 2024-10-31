module Yuriita
  module Definitions
    class Scope
      attr_reader :options, :combination

      def initialize(options:, combination:)
        @options = options
        @combination = combination
      end

      def apply(query:)
        filters = selected_filters(query)
        keywords = query.keywords

        if keywords.present?
          Clauses::Search.new(
            filters:,
            keywords:,
            combination:,
          )
        else
          Clauses::Identity.new
        end
      end

      private

      def selected_filters(query)
        Selects::AllOrExplicit.new(options:, query:).filters
      end
    end
  end
end
