module Yuriita
  module Clauses
    class Merge
      def initialize(clauses:, combination:)
        @clauses = clauses
        @combination = combination
      end

      def call(relation)
        clause_relations = apply_relation_to_clauses(relation)
        combined = combination.new(relations: clause_relations).combine
        relation.merge(combined)
      end

      private

      attr_reader :clauses, :combination

      def apply_relation_to_clauses(relation)
        clauses.map do |clause|
          clause.call(relation)
        end
      end
    end
  end
end
