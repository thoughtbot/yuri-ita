module Yuriita
  module Clauses
    class Filter
      def initialize(filters:, combination:)
        @filters = filters
        @combination = combination
      end

      def apply(relation)
        return relation if unselected?

        relations = filters.map { |filter| filter.apply(relation) }
        combination.new(base_relation: relation, relations: relations).combine
      end

      private

      attr_reader :filters, :combination

      def unselected?
        filters.empty?
      end
    end
  end
end
