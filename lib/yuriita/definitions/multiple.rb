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
          Clauses::Filter.new(filters:, combination:)
        else
          Clauses::Identity.new
        end
      end

      private

      def selected_filters(query)
        Selects::Multiple.new(options:, query:).filters
      end
    end
  end
end
