require "yuriita/clauses/where"
require "yuriita/clauses/where_not"
require "yuriita/clauses/noop"

module Yuriita
  module Filters
    class FixedCondition
      def initialize(expressions:, conditions:)
        @expressions = expressions
        @conditions = conditions
      end

      def apply(expression)
        if matches?(expression)
          build_clause(expression)
        else
          Clauses::Noop.new
        end
      end

      private

      attr_reader :expressions, :conditions

      def matches?(candidate)
        expressions.any? do |expression|
          expression.first == candidate.qualifier &&
            expression.last == candidate.term
        end
      end

      def build_clause(expression)
        if expression.negated?
          Clauses::WhereNot.new(conditions)
        else
          Clauses::Where.new(conditions)
        end
      end
    end
  end
end
