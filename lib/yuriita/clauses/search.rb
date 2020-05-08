module Yuriita
  module Clauses
    class Search
      def initialize(filters:, keywords:, combination:)
        @filters = filters
        @keywords = keywords
        @combination = combination
      end

      def apply(relation)
        return relation if unselected?

        relations = filters.map { |filter| filter.apply(relation, keywords) }
        combination.new(base_relation: relation, relations: relations).combine
      end

      private

      attr_reader :filters, :keywords, :combination

      def unselected?
        filters.empty? || keywords.empty?
      end
    end
  end
end
