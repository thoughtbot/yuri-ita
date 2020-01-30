require "yuriita/clauses/where"
require "yuriita/clauses/where_not"
require "yuriita/clauses/noop"

module Yuriita
  module Filters
    class ValueCondition
      def initialize(qualifiers:, column:)
        @qualifiers = qualifiers
        @column = column
      end

      def apply(expression)
        if matches?(expression)
          build_clause(expression)
        else
          Clauses::Noop.new
        end
      end

      private

      attr_reader :qualifiers, :column

      def matches?(candidate)
        qualifiers.include?(candidate.qualifier)
      end

      def build_clause(expression)
        if expression.negated?
          Clauses::WhereNot.new(column => expression.term)
        else
          Clauses::Where.new(column => expression.term)
        end
      end
    end
  end
end
