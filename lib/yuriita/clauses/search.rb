module Yuriita
  module Clauses
    class Search
      def initialize(filters:, keywords:, combination:)
        @filters = filters
        @keywords = keywords
        @combination = combination
      end

      def apply(relation)
        relations = filters.map { |filter| filter.apply(relation, keywords) }
        combination.new(base_relation: relation, relations:).combine
      end

      private

      attr_reader :filters, :keywords, :combination
    end
  end
end
